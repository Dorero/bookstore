Rails.application.routes.draw do
  root 'home_page#show'
  get '/404', to: 'errors#not_found'

  resources :books, only: [:index, :show]
end
