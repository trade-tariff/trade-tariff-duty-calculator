class RowToNiDutyCalculator
  include CommodityHelper

  attr_reader :user_session

  def initialize(user_session)
    @user_session = user_session
  end

  def options
    uk_options.each_with_object(default_options) do |uk_option, acc|
      case uk_option[:key]
      when DutyOptions::ThirdCountryTariff.id
        acc << DutyOptions::Chooser.new(uk_option, eu_options.mfn, user_session.total_amount).option
      when DutyOptions::TariffPreference.id
        acc << DutyOptions::Chooser.new(uk_option, eu_options.cheapest_preference, user_session.total_amount).option
      end
    end
  end

  private

  def uk_options
    @uk_options ||= DutyCalculator.new(user_session, filtered_commodity(source: 'uk')).options
  end

  def eu_options
    @eu_options ||= DutyCalculator.new(user_session, filtered_commodity(source: 'xi')).options
  end

  def default_options
    return [] if eu_options.preferences.blank? && uk_options.preferences.present?

    OptionCollection.new(eu_options.preferences)
  end
end
