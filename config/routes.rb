Cellar::Application.routes.draw do

  get "sign_up" => "users#new", as: "sign_up"
  get "sign_in" => "sessions#new", as: "sign_in"
  resources :users, only: [:create]
  resources :sessions, only: [:create]
  resources :breweries
  resources :brews
  resources :beers

  root :to => "home#index"
end
