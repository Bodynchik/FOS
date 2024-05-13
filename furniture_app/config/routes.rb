Rails.application.routes.draw do
  # devise_for :users
  devise_for :installs
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
    get 'chat/index'

    resources :order_sets
    resources :prod_sets
    resources :orders
    resources :products do
      collection do
        get :export_csv
      end
    end
    resources :furnitures

    # Шлях до реєстрації користувача
    devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords'
    }

    # Шлях до реєстрації виробника
    devise_for :manufacturers, controllers: {
      sessions: 'manufacturers/sessions',
      registrations: 'manufacturers/registrations',
      passwords: 'users/passwords'
    }

    get 'pages/home'

    resources :chats, only: %i[index create show new] do
      resources :messages, only: [:create]
    end

    resources :sub_categories
    resources :categories
    get '/categories/:category_name/description', to: 'categories#description', as: :description_category

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
    get 'up' => 'rails/health#show', as: :rails_health_check

    # get "sign_in" => "devise/registrations#new", as: :sign_in_page

    # Defines the root path route ("/")
    # root "posts#index"

    mount LetterOpenerWeb::Engine, at: '/letter_opener'
    mount ActionCable.server => '/cable'

    # Add this route for adding product to set
    post 'add_product_to_set', to: 'prod_sets#add_product_to_set'

    get 'comments/index'
    get 'comments/create'
    get 'comments/destroy'

    resources :products do
      resources :comments
    end

    resources :comments, only: %i[index create destroy]
  end
end
