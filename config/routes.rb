# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#index'

  devise_for :users, controllers: { sessions: 'sessions' }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  resources :products, shallow: true do
    resources :likes, only: %i[create destroy]
  end
  resources :order_lines
  resources :orders
  resources :logs, only: [:index]

  get 'cart', to: 'orders#cart'
end
