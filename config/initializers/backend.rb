require 'client_builder'

Rails.application.config.public_routing = ENV.fetch('ROUTE_THROUGH_FRONTEND', 'false') == 'true'

api_options = ENV['API_SERVICE_BACKEND_URL_OPTIONS'] || '{}'

Rails.application.config.api_options = JSON.parse(api_options).symbolize_keys

Rails.application.config.http_client_uk = ClientBuilder.new(:uk).call if Rails.application.config.api_options.present?

Rails.application.config.http_client_xi = ClientBuilder.new(:xi).call if Rails.application.config.api_options.present?
