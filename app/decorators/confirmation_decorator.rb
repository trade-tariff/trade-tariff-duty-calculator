class ConfirmationDecorator < SimpleDelegator
  include ActionView::Helpers::NumberHelper

  ORDERED_STEPS = %w[
    import_date
    import_destination
    country_of_origin
    trader_scheme
    final_use
    planned_processing
    certificate_of_origin
    customs_value
    measure_amount
  ].freeze

  def initialize(object, commodity)
    super(object)

    @commodity = commodity
  end

  def path_for(key:)
    send("#{key}_path")
  end

  def user_answers
    ORDERED_STEPS.each_with_object([]) do |(k, _v), acc|
      next if session_answers[k].blank? || (formatted_value = format_value_for(k)).nil?

      acc << {
        key: k,
        label: I18n.t("confirmation_page.#{k}"),
        value: formatted_value,
      }
    end
  end

  private

  attr_reader :commodity

  def format_value_for(key)
    value = session_answers[key]

    return format_import_date(value) if key == 'import_date'
    return format_customs_value(value) if key == 'customs_value'
    return format_measure_amount(value) if key == 'measure_amount'
    return country_name_for(value, key) if %w[import_destination country_of_origin].include?(key)

    value.humanize
  end

  def session_answers
    @session_answers ||= user_session.session['answers']
  end

  def format_measure_amount(value)
    return if commodity.applicable_measure_units.blank?

    value.map { |k, v| "#{v} #{commodity.applicable_measure_units[k.upcase]['unit']}" }
         .join('<br>')
         .html_safe
  end

  def format_customs_value(_value)
    number_to_currency(user_session.total_amount)
  end

  def format_import_date(value)
    I18n.l(Date.parse(value))
  end

  def country_name_for(value, key)
    return Wizard::Steps::ImportDestination::OPTIONS.find { |c| c.id == value }.name if key == 'import_destination'

    Api::GeographicalArea.find(value, user_session.import_destination.downcase.to_sym).description
  end
end
