Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'home_page#show'

  get '/404', to: 'error#not_found'

  resources :books, only: [:index, :show]
end
