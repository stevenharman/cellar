Cellar::Application.routes.draw do

  resources :breweries

  root :to => "home#index"
end
