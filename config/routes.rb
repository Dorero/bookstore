Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: { passwords: 'users/passwords', registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'home_page#show'

  get '/404', to: 'error#not_found'

  resource :setting, only: [:edit]
  resource :address, only: [:update]
  resource :review, only: [:create]
  resource :cart, only: [:create, :show] do
    get :empty, on: :member
    post :delete_book, on: :member
    post :check_coupon, on: :member
    post :increment_quantity_books, on: :member
    post :decrement_quantity_books, on: :member
    post :update_prices, on: :member
  end

  devise_scope :user do
    resource :check_login, only: [] do
      get :check, on: :member
      post :quick_register, on: :member
      post :login, on: :member
    end
  end

  resource :checking, only: [] do
    get :check_address, on: :member
  end

  resources :books, only: [:index, :show]
end
