Trackble::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users

  resources :devices
  get "current" => "mapper#current", :as => :current_map

  namespace :api do
    devise_for :users, :only => [:registrations, :sessions]
  end

end