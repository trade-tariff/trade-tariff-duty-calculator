module ServiceHelper
  def trade_tariff_url
    full_path_for('/sections')
  end

  def a_to_z_url
    full_path_for('/a-z-index/a')
  end

  def tools_url
    full_path_for('/tools')
  end

  private

  def full_path_for(relative_path)
    return '#' if trade_tariff_frontend_url.blank?

    "#{trade_tariff_frontend_url}#{relative_path}"
  end

  def trade_tariff_frontend_url
    @trade_tariff_frontend_url ||= Rails.configuration.trade_tariff_frontend_url
  end
end
