Rails.application.routes.draw do
  get 'chat/index'
  resources :order_sets
  resources :prod_sets
  resources :orders
  resources :products
  resources :furnitures
  # devise_for :manufacturers
  # devise_for :users

  #Шлях до реєстрації користувача
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  #Шлях до реєстрації виробника
  devise_for :manufacturers, controllers: {
    sessions: 'manufacturers/sessions',
    registrations: 'manufacturers/registrations',
    passwords: 'users/passwords'
  }

  get 'pages/home'
  mount ActionCable.server => '/cable'
  get 'chat', to: 'chat#index'

  resources :sub_categories
  resources :categories

  root 'pages#home'

  namespace :users do
    get '/profiles', to: 'profiles#show'
  end

  namespace :manufacturers do
    get '/profiles', to: 'profiles#show'
  end

  resources :manufacturers do
    resources :products, only: [:index], controller: 'products'
  end



  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # get "sign_in" => "devise/registrations#new", as: :sign_in_page

  # Defines the root path route ("/")
  # root "posts#index"
  mount LetterOpenerWeb::Engine, at: "/letter_opener"

  # Add this route for adding product to set
  post 'add_product_to_set', to: 'prod_sets#add_product_to_set'
end

