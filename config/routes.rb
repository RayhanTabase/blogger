Rails.application.routes.draw do

  devise_for :user

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end

  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create]
  end

  resources :posts, only: [:new, :create, :destroy]


  root to: 'users#index'
end
