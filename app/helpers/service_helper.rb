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

  private

  def service_url_for(relative_path)
    return '#' if trade_tariff_frontend_url.blank?

    File.join(trade_tariff_frontend_url, service_choice, relative_path)
  end

  def trade_tariff_frontend_url
    @trade_tariff_frontend_url ||= Rails.configuration.trade_tariff_frontend_url
  end

  def service_choice
    params[:service_choice] == 'uk' ? '' : params[:service_choice]
  end
end
