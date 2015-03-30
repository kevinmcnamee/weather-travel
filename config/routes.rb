Rails.application.routes.draw do
  scope :api do
    get 'forecast' => 'forecast#index'
  end
end
