Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end

  get '/movies/search', to: 'movies#index'
  
  resources :movies do
    resources :reviews, only: [:new, :create]
  end


  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]

  root to: 'movies#index'
end
