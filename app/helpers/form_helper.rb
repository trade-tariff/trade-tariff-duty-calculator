module FormHelper
  def error_summary(object)
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
    css_classes << 'govuk-form-group--error'
    content_tag(:div, class: css_classes) do
      yield
    end
  end

  def errors_tag(object, attribute)
    content_tag(
      :span,
      ['Date must be provided'].join('<br>').html_safe,
      class: 'govuk-error-message'
    )
  end

  def css_classes_for_input(object, attribute, css_classes = '')
    css_classes = css_classes.split
    css_classes << 'govuk-input'
    css_classes << 'govuk-input--error'
    css_classes.join(' ')
  end
end
