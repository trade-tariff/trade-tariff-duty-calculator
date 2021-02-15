Rails.application.routes.draw do
  get '/duty-calculator/:commodity_code/import-date', to: 'wizard/steps/import_dates#show'
  post '/duty-calculator/:commodity_code/import-date', to: 'wizard/steps/import_dates#create'

  get '/duty-calculator/:commodity_code/import-destination', to: 'wizard/steps/import_destinations#show'
  post '/duty-calculator/:commodity_code/import-destination', to: 'wizard/steps/import_destinations#create'

  get '/404', to: 'errors#not_found', via: :all
  get '/422', to: 'errors#unprocessable_entity', via: :all
  get '/500', to: 'errors#internal_server_error', via: :all
end
