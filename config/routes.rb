Cellar::Application.routes.draw do

  get "sign_up" => "users#new", as: "sign_up"
  get "sign_in" => "sessions#new", as: "sign_in"
  get "sign_out" => "sessions#destroy", as: "sign_out"
  resources :users, only: [:create]
  resources :sessions, only: [:create]
  resources :breweries
  resources :brews
  resources :beers

  root :to => "home#index"
end
