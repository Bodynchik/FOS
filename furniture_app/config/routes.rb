Rails.application.routes.draw do
  get 'pages/home'
  resources :ordered_products
  resources :carts
  resources :prod_raitings
  resources :prod_reviews
  resources :payments
  resources :orders
  resources :clients
  resources :products
  resources :sub_categories
  resources :categories
  resources :manufactures

  root 'pages#home'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

