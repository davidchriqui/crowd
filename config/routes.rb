require 'api_constraints'

Appdj::Application.routes.draw do


  devise_for :users, :controllers => {:registrations => "registrations"}
  # Api definition
  namespace :api, defaults: { format: :json },
            constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do
      # We are going to list our resources here
      resources :users, :only => [:show, :create, :update, :destroy, :index] do
        resources :products, :only => [:create, :update, :destroy]
      end
      resources :sessions, :only => [:create, :destroy]
      resources :playlists, :only => [:create, :show, :index, :destroy]
      resources :user_playlists, :only => [:create, :destroy]
      resources :songs, :only => [:create, :index, :update]
    end
  end
end