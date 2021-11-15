Rails.application.routes.draw do
  root 'home_page#show'

  resources :books, only: [:index, :show]
  get '/books/category/:id', to: 'books#category'
end
