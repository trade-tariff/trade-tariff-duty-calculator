module FormHelper
  def error_summary(object)
    return unless object.errors.any?

    content_tag('div', class: 'govuk-error-summary', **error_summary_attributes) do
      safe_join(
        [
          tag.h2('There is a problem', id: 'error-summary-title', class: 'govuk-error-summary__title'),
          error_list(object)
        ]
      )
    end
  end

  def form_group_tag(object, attribute, tag_class: [], &_block)
    css_classes = ['govuk-form-group'] + tag_class
    css_classes << 'govuk-form-group--error' if object.errors.key?(attribute)
    content_tag(:div, class: css_classes) do
      yield
    end
  end

  def errors_tag(object, attribute)
    return unless object.errors.messages[attribute].present?

    content_tag(
      :span,
      messages(object, attribute).join('<br>').html_safe,
      class: 'govuk-error-message',
      id: error_id(object.class.model_name.singular, attribute)
    )
  end

  def errors_tag_minimal(object, attribute)
    return unless object.errors.messages[attribute].present?

    content_tag(
      :span,
      nil,
      class: 'govuk-error-message-placeholder'
    )
  end

  def css_classes_for_input(object, attribute, css_classes = '')
    css_classes = css_classes.split
    css_classes << 'govuk-input'
    css_classes << 'govuk-input--error' if object.errors.key?(attribute)
    css_classes.join(' ')
  end

  private

  def error_id(object_name, attribute)
    "#{object_name}_#{attribute}-error"
  end

  def messages(object, attribute)
    object.errors.messages[attribute].map { |message|
      content_tag(:span, 'Error:', class: 'govuk-visually-hidden') + ' ' + message
    }
  end

  def error_summary_attributes
    {
      tabindex: -1,
      role: 'alert',
      data: {
        module: 'govuk-error-summary'
      },
      aria: {
        labelledby: 'error-summary-title'
      }
    }
  end

  def error_list(object)
    content_tag('div', class: 'govuk-error-summary__body') do
      content_tag('ul', class: 'govuk-list govuk-error-summary__list') do
        safe_join(
          object.errors.messages.map { |attribute, messages|
            error_list_item(object.class.model_name.singular, attribute, messages.first)
          }
        )
      end
    end
  end

  def error_list_item(object_name, attribute, message)
    content_tag('li') do
      link_to(
        message,
        '#' + error_id(object_name, attribute)
      )
    end
  end
end
