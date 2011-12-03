BrewdegaCellar::Application.routes.draw do

  get "sign_up" => "users#new", as: "sign_up"
  get "sign_in" => "sessions#new", as: "sign_in"
  get "sign_out" => "sessions#destroy", as: "sign_out"

  resources :users, only: [:create]
  resources :users, path: '', only: [] do
    resources :beers, path: 'beer', only: [:show, :edit, :update]
  end
  resources :sessions, only: [:create]

  resources :breweries
  resources :brews
  resources :beers, only: [:index, :new, :create]

  get "/:username" => "cellars#show", as: :cellar

  root :to => "home#index"
end
