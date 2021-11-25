module ServiceHelper
  def title
    t("title.#{referred_service}")
  end

  def header
    t("header.#{referred_service}")
  end

  def sections_url
    service_url_for('/sections')
  end

  def search_url
    service_url_for('/find_commodity')
  end

  def browse_url
    service_url_for('/browse')
  end

  def a_to_z_url
    service_url_for('/a-z-index/a')
  end

  def tools_url
    service_url_for('/tools')
  end

  def updates_url
    service_url_for('/updates')
  end

  def help_url
    service_url_for('/help')
  end

  def previous_service_url(commodity_code)
    UserSession.get&.redirect_to.presence || commodity_url(commodity_code)
  end

  def commodity_url(commodity_code)
    service_url_for("/commodities/#{commodity_code}")
  end

  def feedback_url
    service_url_for('/feedback')
  end

  def trade_tariff_frontend_url
    @trade_tariff_frontend_url ||= Rails.configuration.trade_tariff_frontend_url
  end

  def meursing_lookup_url
    xi_only_service_url_for('/meursing_lookup/steps/start')
  end

  private

  def service_url_for(path)
    return '#' if trade_tariff_frontend_url.blank?

    File.join(trade_tariff_frontend_url, referred_service_url, path)
  end

  def xi_only_service_url_for(path)
    return '#' if trade_tariff_frontend_url.blank?

    File.join(trade_tariff_frontend_url, 'xi', path)
  end

  def referred_service_url
    referred_service == 'uk' ? '' : referred_service.to_s
  end

  def referred_service
    params[:referred_service] || session['referred_service'] || 'uk'
  end
end
