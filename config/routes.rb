Rails.application.routes.draw do

  devise_for :user
  devise_scope :user do
    get '/user/sign_out' => 'devise/sessions#destroy'
  end

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end

  resources :posts do
    resources :comments, only: [:create]
    resources :likes, only: [:create]
  end

  resources :posts, only: [:new, :create]

  root to: 'users#index'
end
