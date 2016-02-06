Rails.application.routes.draw do

  namespace :admin do
    get "/dashboard", to: "dashboard#show"
    resources :categories, only: [:index, :create, :edit, :update, :destroy]
  end

  resources :donations, only: [:create]
  resources :categories, only: [:index, :show]
  resources :users, only: [:new, :create, :edit, :update, :show]

  namespace :users, path: ':user', as: :user do
    resources :causes, only: [:index, :show, :new, :create, :edit, :update]
  end

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/about", to: "static#about"
  # put "/status" to: 

  root "static#home"
end
