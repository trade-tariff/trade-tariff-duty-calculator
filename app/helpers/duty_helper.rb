module DutyHelper
  def company_warning_text
    t('duty_calculations.options.company_warning_text', commodity_link: commodity_link).html_safe if filtered_commodity.company_defensive_measures?
  end

  private

  def commodity_link
    link_to('commodity page', commodity_url(commodity_code))
  end
end
