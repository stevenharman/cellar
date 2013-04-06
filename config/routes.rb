BrewdegaCellar::Application.routes.draw do

  devise_for :user, skip: :all
  devise_scope :user do
    get 'sign_in' => 'sessions#new', as: :new_user_session
    post 'sign_in' => 'sessions#create', as: :user_session
    delete 'sign_out' => 'sessions#destroy', as: :destroy_user_session

    resource :confirmation, only: [:new, :create, :show]
    namespace :settings do
      resource :password, only: [:new, :create, :edit, :update]
    end
  end

  get 'sign_up' => 'users#new'
  resources :users, only: [:create]
  resources :users, path: '', only: [], as: :cellar do
    resources :beers, controller: :cellar_beers, only: [:show]
    resource :distribution_order, controller: :distribution_orders, only: [:update]
  end

  resources :breweries, only: [:index, :show]
  resources :brews, only: [:index, :show]
  resources :beer_orders, only: [:new, :create]

  resource :search, only: [:show]

  resource :heartbeat, only: [:show]
  resources :webhooks, controller: :web_hooks, only: [:create]

  require 'sidekiq/web'
  mount Sidekiq::Web => '/secret-sidekiq'

  get '/:username' => 'cellars#show', as: :cellar

  root :to => 'home#index'
end
