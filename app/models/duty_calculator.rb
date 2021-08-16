class DutyCalculator
  include CommodityHelper

  def initialize(commodity)
    @commodity = commodity
  end

  def options
    options = commodity.applicable_measures.select(&:applicable?).each_with_object(default_options) do |measure, acc|
      option_klass = measure.measure_type.option

      next if option_klass.nil?

      option = {}
      option[:key] = option_klass.id
      option[:evaluation] = option_klass.new(measure, additional_duty_rows, vat_measure).option

      acc << option
    end

    options.sort_by { |h| h[:evaluation][:priority] }
  end

  private

  attr_reader :commodity

  def additional_duty_rows
    rows = AdditionalDutyApplicableMeasuresMerger.new.call.each_with_object([]) do |measure, acc|
      option_klass = measure.measure_type.additional_duty_option

      next if option_klass.nil?
      next if measure.all_duties_zero?

      option = {}
      option[:key] = option_klass.id
      option[:evaluation] = option_klass.new(measure, [], nil).option
      acc << option
    end

    rows.sort_by { |option| option[:evaluation][:priority] }
  end

  def default_options
    return OptionCollection.new([waiver_option]) if user_session.gb_to_ni_route?

    OptionCollection.new([])
  end

  def waiver_option
    {}.tap do |option|
      option[:key] = DutyOptions::Waiver.id
      option[:evaluation] = DutyOptions::Waiver.new(nil, [], nil).option
    end
  end

  def vat_measure
    @vat_measure ||= begin
      vat_measures = uk_filtered_commodity.import_measures.select(&:vat)

      return vat_measures.first if vat_measures.size == 1

      vat_measures.find { |measure| measure.vat_type == user_session.vat }
    end
  end

  def user_session
    UserSession.get
  end
end
