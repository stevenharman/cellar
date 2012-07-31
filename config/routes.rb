BrewdegaCellar::Application.routes.draw do

  devise_for :user, skip: :all
  as :user do
    get 'sign_in' => 'sessions#new', as: :new_user_session
    post 'sign_in' => 'sessions#create', as: :user_session
    delete 'sign_out' => 'sessions#destroy', as: :destroy_user_session
  end

  get 'sign_up' => 'users#new'
  resources :users, only: [:create]
  resources :users, path: '', only: [] do
    get "brews/:id" => "cellar_brews#show", as: :cellar_brew

    resources :cellar_beers, path: 'beers', only: [:show, :edit, :update] do
      put :drink, on: :member
    end
  end

  resources :breweries
  resources :brews
  resources :beers, only: [:index, :new, :create]

  require 'sidekiq/web'
  mount Sidekiq::Web => '/secret-sidekiq'

  get "/:username" => "cellars#show", as: :cellar

  root :to => "home#index"
end
