Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }

  devise_scope :user do
    get "user/:id", to: "users/registrations#detail"
    get "signup", to: "users/registrations#new"
    get "login", to: "users/sessions#new"
    get "logout", to: "users/sessions#destroy"
  end
  resources :admin, only: [:index]
  namespace :admin do
    resources :users, only: [:index, :edit, :update, :destroy]
    resources :topics, only: [:index, :destroy]
  end
  resources :topics, only: [:index, :show, :new, :create]
  resources :posts, only: [:create]
  resources :home, only: [:index]
  resources :friends, only: [:index, :show, :destroy]
  resources :users, only: [:show]
  resources :top, only: [:index]
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
