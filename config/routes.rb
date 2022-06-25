Rails.application.routes.draw do
  devise_for :user
  
  devise_scope :user do
    get '/user/sign_out' => 'devise/sessions#destroy'
  end

  resources :users, only: [:index, :show, :create] do
    resources :posts, only: [:index, :show]
  end

  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"

  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create]
  end

  resources :posts, only: [:new, :create, :destroy]

  root to: 'users#index'
end
