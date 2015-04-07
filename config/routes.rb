Rails.application.routes.draw do
  root 'trips#index'
  resources :trips, only: :index do
    post 'search', on: :collection
  end

  namespace :api do
    get 'forecast' => 'forecast#index'
  end
end
