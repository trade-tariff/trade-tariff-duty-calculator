module ServiceHelper
  def title
    t("title.#{referred_service}")
  end

  def header
    t("header.#{referred_service}")
  end

  def trade_tariff_url
    service_url_for('/sections')
  end

  def a_to_z_url
    service_url_for('/a-z-index/a')
  end

  def tools_url
    service_url_for('/tools')
  end

  def commodity_url(commodity_code)
    service_url_for("/commodities/#{commodity_code}")
  end

  def feedback_url
    service_url_for('/feedback')
  end

  def help_url
    service_url_for('/help')
  end

  def trade_tariff_frontend_url
    @trade_tariff_frontend_url ||= Rails.configuration.trade_tariff_frontend_url
  end

  private

  def service_url_for(relative_path)
    return '#' if trade_tariff_frontend_url.blank?

    File.join(trade_tariff_frontend_url, referred_service_url, relative_path)
  end

  def referred_service_url
    referred_service == 'uk' ? '' : referred_service.to_s
  end

  def referred_service
    params[:referred_service] || session['referred_service'] || 'uk'
  end
end
