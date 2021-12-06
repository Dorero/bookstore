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
    post :delete_book, on: :member
    post :check_coupon, on: :member
  end

  resources :books, only: [:index, :show]
end
