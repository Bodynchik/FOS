Rails.application.routes.draw do
  # devise_for :manufacturers
  # devise_for :users

  #Шлях до реєстрації користувача
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  #Шлях до реєстрації виробника
  devise_for :manufacturers, controllers: {
    sessions: 'manufacturers/sessions',
    registrations: 'manufacturers/registrations'
  }

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

  namespace :users do
    get '/profiles', to: 'profiles#show'
  end

  namespace :manufacturers do
    get '/profiles', to: 'profiles#show'
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # get "sign_in" => "devise/registrations#new", as: :sign_in_page

  # Defines the root path route ("/")
  # root "posts#index"
end

