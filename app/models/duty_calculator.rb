class DutyCalculator
  def initialize(user_session, commodity)
    @user_session = user_session
    @commodity = commodity
  end

  def result
    return nil if user_session.ni_to_gb_route? || user_session.eu_to_ni_route? || no_duty_applies?

    calculate_duty
  end

  private

  attr_reader :user_session, :commodity

  def calculate_duty
    options = applicable_measures.each_with_object(default_options) do |measure, acc|
      option_klass = measure.measure_type.option

      next if option_klass.nil?

      option = {}
      option[:key] = option_klass.id
      option[:evaluation] = option_klass.new(measure, user_session, additional_duty_rows).option
      option[:priority] = option_klass::PRIORITY

      acc << option
    end

    options.sort_by { |h| h[:priority] }
  end

  def zero_mfn_duty_no_trade_defence?
    !user_session.trade_defence && user_session.zero_mfn_duty
  end

  def strict_processing?
    %w[without_any_processing annual_turnover commercial_processing].include?(user_session.planned_processing)
  end

  def certificate_of_origin?
    user_session.certificate_of_origin == 'yes'
  end

  def additional_duty_rows
    @additional_duty_rows ||=
      applicable_measures.each_with_object([]) do |measure, acc|
        option_klass = measure.measure_type.additional_duty_option

        next if option_klass.nil?
        next if measure.all_duties_zero?

        acc << option_klass.new(measure, user_session, []).option
      end
  end

  def default_options
    return [waiver_option] if user_session.gb_to_ni_route?

    []
  end

  def waiver_option
    {}.tap do |option|
      option[:key] = DutyOptions::Waiver.id
      option[:evaluation] = DutyOptions::Waiver.new(nil, user_session, []).option
      option[:priority] = DutyOptions::Waiver::PRIORITY
    end
  end

  def applicable_measures
    @applicable_measures ||= no_additional_code_measures + additional_code_measures + vat_measures
  end

  def additional_code_measures
    commodity.import_measures.reject(&:vat).select do |measure|
      additional_code = measure.additional_code
      code_answer = user_session.additional_code[measure.measure_type.id]

      additional_code.present? && code_answer == additional_code.code
    end
  end

  def vat_measures
    commodity.import_measures.each_with_object([]) do |measure, acc|
      vat_type = measure.vat_type

      next if vat_type.nil?

      acc << measure if commodity.applicable_vat_options.keys.size == 1 || user_session.vat == vat_type
    end
  end

  def no_additional_code_measures
    commodity.import_measures.reject(&:additional_code).reject(&:vat)
  end

  def no_duty_applies?
    relevant_route? && (zero_mfn_duty_no_trade_defence? || strict_processing? || certificate_of_origin?)
  end

  def relevant_route?
    user_session.gb_to_ni_route? || user_session.row_to_gb_route?
  end
end
