Rails.application.routes.draw do
  root   'static_pages#home'
  get    '/contact' => 'static_pages#contact'
  get    '/signup'  => 'users#new'
  get    '/login'   => 'sessions#new'
  post   '/login'   => 'sessions#create'
  delete '/logout'  => 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :relationships,       only: [:create, :destroy]
  resources :imageposts,          only: [:show, :create, :destroy] do
    resources :comments, only: [:create, :destroy]
    resource  :likes,    only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  resources :notifications,       only: [:index, :destroy] do
    collection do
      delete 'destroy_all'
    end
  end
end
