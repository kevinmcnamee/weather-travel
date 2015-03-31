Rails.application.routes.draw do
  namespace :api do
    get 'forecast' => 'forecast#index'
  end
end
