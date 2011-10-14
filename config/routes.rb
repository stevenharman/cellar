Cellar::Application.routes.draw do

  resources :breweries
  resources :brews
  resources :beers

  root :to => "home#index"
end
