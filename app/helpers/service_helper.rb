module ServiceHelper
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

  private

  def service_url_for(relative_path)
    return '#' if trade_tariff_frontend_url.blank?

    File.join(trade_tariff_frontend_url, service_choice_url, relative_path)
  end

  def trade_tariff_frontend_url
    @trade_tariff_frontend_url ||= Rails.configuration.trade_tariff_frontend_url
  end

  def service_choice_url
    return '' if params[:service_choice] == 'uk'

    params[:service_choice]
  end
end
