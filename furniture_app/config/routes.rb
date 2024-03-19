Rails.application.routes.draw do
  devise_for :users
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

  get "sign_in2" => "pages#sign_in", as: :sign_in_page2
  get "sign_in" => "devise/registrations#new", as: :sign_in_page

  # Defines the root path route ("/")
  # root "posts#index"
end

