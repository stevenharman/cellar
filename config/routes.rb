Cellar::Application.routes.draw do

  get "sign_up" => "users#new", as: "sign_up"
  resources :users, only: [:create]
  resources :breweries
  resources :brews
  resources :beers

  root :to => "home#index"
end
