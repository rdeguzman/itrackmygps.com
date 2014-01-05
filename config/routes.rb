Trackble::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users

  namespace :api do
    devise_for :users, :only => :registrations
  end
end