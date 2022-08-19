# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper
  root 'products#index'

  devise_for :users, controllers: { sessions: 'sessions' }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  namespace :api do
    namespace :v1 do
      concern :commentable do
        resources :comments
      end

      resources :products do
        resources :likes, shallow: true, only: %i[create]
      end
      resources :order_lines
      resources :orders
      resources :users, concerns: :commentable
      resources :transactions, only: [:index]
      post '/authenticate', to: 'authentication#authenticate'
      post '/webhook', to: 'orders#webhook'
    end
  end

  concern :commentable do
    resources :comments
  end

  resources :products, concerns: :commentable do
    resources :likes, shallow: true, only: %i[create destroy]
  end
  resources :order_lines
  resources :orders, concerns: :commentable
  post 'checkout', to: 'orders#checkout'
  resources :logs, only: [:index]
  resources :transactions, only: [:index]
  get 'cart', to: 'orders#cart'

  resources :apidocs, only: [:index]
  get 'json', to: 'apidocs#json'
end
