Rails.application.routes.draw do
  # devise_for :user
  devise_for :users,
               controllers: {
                 sessions: 'sessions',
                 registrations: 'registrations'
               }
  
  get '/logout' => 'users#destroy'
  post "/login" => 'users#login'
  post "/signup" => 'users#create'

  resources :users do
    resources :items
  end

  resources :posts do
    resources :items
    resources :comments do
      resources :items
    end
  end
  
  root to: 'users#index'
  mount Rswag::Ui::Engine => 'api-docs'
  mount Rswag::Api::Engine => 'api-docs'
end
