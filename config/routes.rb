Rails.application.routes.draw do
  devise_for :users

  resources :messages

  get "up" => "rails/health#show", as: :rails_health_check

  root "messages#index"
end
