Rails.application.routes.draw do

  namespace :admin do
    get "/dashboard", to: "dashboard#show"
    resources :categories, only: [:index, :create, :edit, :update, :destroy]
  end

  resources :donations, only: [:create]
  resources :categories, only: [:index, :show]
  resources :users, only: [:new, :create, :edit, :update, :show, :destroy]

  namespace :users, path: ':user', as: :user do
    resources :causes
  end

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/about", to: "static#about"
  get "/auth/twitter", as: :twitter_login
  get "/auth/twitter/callback", to: "sessions#create"
  resources :tweets, only: [:new, :create]
  root "static#home"
end
