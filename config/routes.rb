Rails.application.routes.draw do
  root "products#index"

  devise_for :users, :controllers => { :sessions => "sessions"}
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  resources :products, shallow: true do
    resources :likes, only: [:create, :destroy]
  end
  resources :order_lines
  resources :orders, only: [:update]

  get 'cart', to: 'orders#show'
end
