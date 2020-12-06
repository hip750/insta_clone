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
  resources :imageposts,          only: [:show, :create, :destroy] do
    resources :comments, only: [:create, :destroy]
    resource  :likes,    only: [:create, :destroy]
  end
  resources :relationships,       only: [:create, :destroy]
end
