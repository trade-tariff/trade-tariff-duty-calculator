class DutyCalculator
  include CommodityHelper

  def initialize(commodity)
    @commodity = commodity
  end

  def options
    options = applicable_measures.each_with_object(default_options) do |measure, acc|
      option_klass = measure.measure_type.option

      next if option_klass.nil?

      option = {}
      option[:key] = option_klass.id
      option[:evaluation] = option_klass.new(measure, additional_duty_rows, vat_measure).option
      option[:priority] = option_klass::PRIORITY

      acc << option
    end

    options.sort_by { |h| h[:priority] }
  end

  private

  attr_reader :commodity

  def additional_duty_rows
    @additional_duty_rows ||=
      applicable_measures.each_with_object([]) do |measure, acc|
        option_klass = measure.measure_type.additional_duty_option

        next if option_klass.nil?
        next if measure.all_duties_zero?

        acc << option_klass.new(measure, [], nil).option
      end
  end

  def default_options
    return OptionCollection.new([waiver_option]) if user_session.gb_to_ni_route?

    OptionCollection.new([])
  end

  def waiver_option
    {}.tap do |option|
      option[:key] = DutyOptions::Waiver.id
      option[:evaluation] = DutyOptions::Waiver.new(nil, [], nil).option
      option[:priority] = DutyOptions::Waiver::PRIORITY
    end
  end

  def applicable_measures
    @applicable_measures ||= no_additional_code_measures + additional_code_measures
  end

  def additional_code_measures
    commodity.import_measures.reject(&:vat).select do |measure|
      additional_code = measure.additional_code
      code_answer = user_session.public_send("additional_code_#{commodity.source}")[measure.measure_type.id]
      additional_code.present? && code_answer == additional_code.code
    end
  end

  def vat_measure
    @vat_measure ||= begin
      vat_measures = uk_filtered_commodity.import_measures.select(&:vat)

      return vat_measures.first if vat_measures.size == 1

      vat_measures.find { |measure| measure.vat_type == user_session.vat }
    end
  end

  def uk_filtered_commodity
    filtered_commodity(source: 'uk')
  end

  def no_additional_code_measures
    commodity.import_measures.reject(&:additional_code).reject(&:vat)
  end

  def user_session
    UserSession.get
  end
end
