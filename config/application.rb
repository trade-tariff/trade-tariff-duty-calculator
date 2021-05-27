require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_record/attribute_assignment'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'

Bundler.require(*Rails.groups)

module TradeTariffDutyCalculator
  class Application < Rails::Application
    config.load_defaults 5.2
    config.middleware.use Rack::Deflater
    config.time_zone                 = 'London'
    config.exceptions_app            = routes
    config.trade_tariff_frontend_url = ENV['TRADE_TARIFF_FRONTEND_URL']
    config.duty_calculator_host      = ENV.fetch('DUTY_CALCULATOR_HOST', 'http://localhost')
    config.row_to_ni                 = ENV.fetch('ROW_TO_NI', 'false')
  end
end
