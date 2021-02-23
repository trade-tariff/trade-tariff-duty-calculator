class DutyCalculator
  attr_reader :user_session

  def initialize(user_session)
    @user_session = user_session
  end

  def result
    0 if user_session.ni_to_gb_route? || user_session.eu_to_ni_route?
  end
end
