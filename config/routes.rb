Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  post '/question_1', to: 'home#question_1'
  get '/question_2', to: 'home#question_2'
end
