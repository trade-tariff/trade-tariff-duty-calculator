module ServiceHelper
  TRADE_TARIFF_DOMAINS = {
    development: 'https://dev.trade-tariff.service.gov.uk',
    staging: 'https://staging.trade-tariff.service.gov.uk',
    production: 'https://www.trade-tariff.service.gov.uk',
  }.freeze

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
    return '#' if trade_tariff_frontend_origin.blank?

    "#{TRADE_TARIFF_DOMAINS[trade_tariff_frontend_origin.to_sym]}#{relative_path}"
  end

  def trade_tariff_frontend_origin
    @trade_tariff_frontend_origin ||= Rails.configuration.trade_tariff_frontend_origin
  end
end
