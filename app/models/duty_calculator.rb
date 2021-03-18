class DutyCalculator
  attr_reader :user_session

  def initialize(user_session)
    @user_session = user_session
  end

  def result
    return 0 if user_session.ni_to_gb_route? || user_session.eu_to_ni_route?

    gb_to_ni_duty if user_session.gb_to_ni_route?
  end

  private

  def gb_to_ni_duty
    return 0 if zero_mfn_duty_no_trade_defence? || strict_processing? || certificate_of_origin?
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
end
