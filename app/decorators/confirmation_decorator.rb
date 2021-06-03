class ConfirmationDecorator < SimpleDelegator
  include ActionView::Helpers::NumberHelper

  ORDERED_STEPS = %w[
    additional_code
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
    return import_date_path(referred_service: user_session.referred_service, commodity_code: user_session.commodity_code) if key == 'import_date'

    return additional_codes_path(user_session.additional_code.keys.first) if key == 'additional_code'

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
    return additional_codes_for(value) if key == 'additional_code'

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

    value = user_session.other_country_of_origin if value == 'OTHER'

    Api::GeographicalArea.find(value, user_session.import_destination.downcase.to_sym).description
  end

  def additional_codes_for(value)
    return nil if value.empty?

    value.values.join(', ')
  end
end
