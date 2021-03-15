require 'client_builder'

Rails.application.config.api_options = JSON.parse(ENV['API_SERVICE_BACKEND_URL_OPTIONS']).symbolize_keys

Rails.application.config.http_client_uk = ClientBuilder.new(:uk).call

Rails.application.config.http_client_xi = ClientBuilder.new(:xi).call
