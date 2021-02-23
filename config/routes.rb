Rails.application.routes.draw do
  scope path: '/:service_choice/duty-calculator/:commodity_code' do
    get 'import-date', to: 'wizard/steps/import_dates#show'
    post 'import-date', to: 'wizard/steps/import_dates#create'

    get 'import-destination', to: 'wizard/steps/import_destinations#show'
    post 'import-destination', to: 'wizard/steps/import_destinations#create'

    get 'country-of-origin', to: 'wizard/steps/country_of_origin#show'
    post 'country-of-origin', to: 'wizard/steps/country_of_origin#create'

    get 'duty', to: 'wizard/steps/duties#show'
  end

  get '404', to: 'errors#not_found', via: :all
  get '422', to: 'errors#unprocessable_entity', via: :all
  get '500', to: 'errors#internal_server_error', via: :all
end
