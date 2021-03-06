Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create] do
    member do
      get :likes
    end
  end
  
  resources :homes, only: [:index]
  resources :posts, only: [:index, :create, :destroy]
  resources :notices, only: [:index, :new, :edit, :update, :create, :destroy]
  resources :favorites, only: [:create, :destroy]
end
