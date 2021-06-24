class RowToNiDutyCalculator
  include CommodityHelper

  attr_reader :user_session

  def initialize(user_session)
    @user_session = user_session
  end

  def result
    uk_mfn_option = uk_options.find { |option| option[:key] == DutyOptions::ThirdCountryTariff.id }
    xi_mfn_option = xi_options.find { |option| option[:key] == DutyOptions::ThirdCountryTariff.id }

    [DutyOptions::Chooser.new(uk_mfn_option, xi_mfn_option, user_session.total_amount).option]
  end

  private

  def uk_options
    @uk_options ||= DutyCalculator.new(user_session, filtered_commodity(source: 'uk')).result
  end

  def xi_options
    @xi_options ||= DutyCalculator.new(user_session, filtered_commodity(source: 'xi')).result
  end
end
