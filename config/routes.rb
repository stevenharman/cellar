Cellar::Application.routes.draw do

  resources :breweries
  resources :brews

  root :to => "home#index"
end
