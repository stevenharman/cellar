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
    get "brew/:id" => "cellars#brew", as: :brew

    resources :beers, path: 'beer', only: [:show, :edit, :update] do
      put :drink, on: :member
    end
  end

  resources :breweries
  resources :brews
  resources :beers, only: [:index, :new, :create]

  get "/:username" => "cellars#show", as: :cellar

  root :to => "home#index"
end
