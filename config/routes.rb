Rails.application.routes.draw do
  namespace :api do
    get 'forecast' => 'forecast#index'
  end

  root 'forecast#index'
  post '/forecast/search', to: 'forecast#search'
end
