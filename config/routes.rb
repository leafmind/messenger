Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  mount GrapeSwaggerRails::Engine => '/swagger'
  mount API => '/'

  devise_for :users

  resources :rooms, only: [:new, :create, :show, :index]
  resources :messages
  
  root to: "rooms#index"
end
