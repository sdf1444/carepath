Rails.application.routes.draw do
  root "dashboard#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :patients, only: [:index, :show] do
    resources :care_transitions, only: [:create]
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
