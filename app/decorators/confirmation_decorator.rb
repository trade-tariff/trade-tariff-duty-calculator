class ConfirmationDecorator < SimpleDelegator
  include ActionView::Helpers::NumberHelper
  include CommodityHelper

  ORDERED_STEPS = %w[
    additional_code
    document_code
    import_date
    import_destination
    country_of_origin
    trader_scheme
    final_use
    annual_turnover
    planned_processing
    certificate_of_origin
    customs_value
    measure_amount
    excise
    vat
  ].freeze

  def initialize(confirmation_step, commodity)
    super(confirmation_step)

    @commodity = commodity
  end

  def path_for(key:)
    return import_date_path(referred_service: user_session.referred_service, commodity_code: user_session.commodity_code) if key == 'import_date'

    return additional_codes_path(applicable_measure_type_ids.first) if key == 'additional_code'
    return document_codes_path(document_codes_applicable_measure_type_ids.first) if key == 'document_code'
    return excise_path(applicable_excise_measure_type_ids.first) if key == 'excise'

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
    return annual_turnover(value) if key == 'annual_turnover'
    return additional_codes_for(value) if key == 'additional_code'
    return document_codes_for(value) if key == 'document_code'
    return excise_for(value) if key == 'excise'
    return vat_label(value) if key == 'vat'

    value.humanize
  end

  def session_answers
    @session_answers ||= user_session.session['answers']
  end

  def format_measure_amount(value)
    return if commodity.applicable_measure_units.blank?

    value.map { |k, v| "#{v} #{applicable_measure_units[k.upcase]['unit']}" }
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
    return Steps::ImportDestination::OPTIONS.find { |c| c.id == value }.name if key == 'import_destination'

    value = user_session.other_country_of_origin if value == 'OTHER'

    Api::GeographicalArea.find(value, user_session.import_destination.downcase.to_sym).description
  end

  def annual_turnover(value)
    return 'Less than £500,000' if value == 'yes'

    'Greater than or equal to £500,000'
  end

  def vat_label(value)
    applicable_vat_options[value]
  end

  def additional_codes_for(value)
    return nil unless value.values.any? { |v| v.values.compact.present? }

    user_session.additional_codes
  end

  def excise_for(value)
    return nil unless value.values.any?

    excise_additional_codes
  end

  def excise_additional_codes
    user_session.excise_additional_code.values.join(', ')
  end

  def document_codes_for(_answer)
    return nil if user_session.document_code_uk.empty? && user_session.document_code_xi.empty?
    return document_codes.uniq.sort.join(', ') if document_codes.present?

    'n/a'
  end

  def document_codes
    uk_document_codes = fetch_document_codes_for('uk')
    xi_document_codes = fetch_document_codes_for('xi')

    uk_document_codes.concat(xi_document_codes)
  end

  def fetch_document_codes_for(source)
    user_session.public_send("document_code_#{source}").values.flatten.reject { |code| code == 'None' }
  end

  def user_session
    UserSession.get
  end
end
