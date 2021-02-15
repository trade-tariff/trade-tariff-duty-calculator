require 'routing_filter/service_prefix_filter'

Rails.application.routes.draw do
  filter :service_prefix_filter
  default_url_options(host: Rails.application.config.duty_calculator_host)

  scope path: '/duty_calculator/:commodity_code' do
    resource :import_date, only: %i[show create], controller: 'wizard/steps/import_dates'
    resource :import_destination, only: %i[show create], controller: 'wizard/steps/import_destinations'
  end

  get '/404', to: 'errors#not_found', via: :all
  get '/422', to: 'errors#unprocessable_entity', via: :all
  get '/500', to: 'errors#internal_server_error', via: :all
end
