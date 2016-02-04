Rails.application.routes.draw do
  post "headshot/capture" => 'headshot#capture', :as => :headshot_capture

  namespace :admin do
    get "/dashboard", to: "dashboard#show"
    resources :categories, only: [:index, :create, :edit, :update, :destroy]
    resources :staches, only: [:new, :create, :index, :edit, :destroy, :update]
    resources :orders, only: [:show]
    put "cancel_order", to: "orders#cancel"
    put "paid_order", to: "orders#paid"
    put "complete_order", to: "orders#complete"
    put "retire_stache", to: "staches#retire"
    put "activate_stache", to: "staches#activate"
  end



  resources :cart_staches, only: [:create, :destroy]
  resource :cart, only: [:show]
  resources :categories, only: [:index, :show]
  resources :users, only: [:new, :create, :edit, :update, :show]

  namespace :users, path: ':user', as: :user do
    resources :causes, only: [:index, :show, :new, :create]
  end


  resources :orders, only: [:index, :show, :new, :create]

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  # get "/dashboard", to: "users#show"
  post "update_quantity", to: "cart_staches#update_quantity"
  get "/about", to: "static#about"

  root "welcome#home"
end
