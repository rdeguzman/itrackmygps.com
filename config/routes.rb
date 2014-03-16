Itrackmygps::Application.routes.draw do
  root :to => 'home#index'
  devise_for :users, :controllers => {:registrations => 'registrations'}
  resources :users

  resources :devices
  get 'current' => 'mapper#current', :as => :current_map
  get 'access' => 'mapper#access', :as => :map_access
  post 'live' => 'mapper#live', :as => :map_live
  get 'restricted' => 'mapper#restricted'

  get 'privacy' => 'home#privacy'

  namespace :api do
    #devise_for :users, :only => [:registrations, :sessions]

    post 'login', :to => 'sessions#create', :as => :user_session
    post 'register', :to => 'registrations#create', :as => :user_registration
    get 'devices', :to => "devices#index"
  end

end