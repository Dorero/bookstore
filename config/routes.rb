Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'home_page#show'

  get '/404', to: 'error#not_found'

  resources :books, only: [:index, :show]
  resources :user, only: [:edit, :update]
  resources :billing, only: [:edit, :update]
  resources :shipping, only: [:update]
end
