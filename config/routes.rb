Trackble::Application.routes.draw do
  root :to => "home#index"

  namespace :api do
    devise_for :users
  end

  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users

end