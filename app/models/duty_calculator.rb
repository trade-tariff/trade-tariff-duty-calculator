class DutyCalculator
  def initialize(user_session, commodity)
    @user_session = user_session
    @commodity = commodity
  end

  def result
    return nil if user_session.ni_to_gb_route? || user_session.eu_to_ni_route?

    gb_to_ni_duty if user_session.gb_to_ni_route?
  end

  private

  attr_reader :user_session, :commodity

  def gb_to_ni_duty
    return nil if zero_mfn_duty_no_trade_defence? || strict_processing? || certificate_of_origin?

    commodity.import_measures.each_with_object({}) do |measure, options|
      if measure.measure_type.third_country?
        options[:third_country_tariff] = DutyOptions::ThirdCountryTariffOption.new(measure, user_session, additional_duty_rows).option
      elsif measure.measure_type.tariff_preference?
        options[:tariff_preference] = DutyOptions::TariffPreferenceOption.new(measure, user_session, additional_duty_rows).option
      end
    end
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
    []
  end
end
