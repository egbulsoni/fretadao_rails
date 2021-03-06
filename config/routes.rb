# frozen_string_literal: true

Rails.application.routes.draw do
  resources :profiles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'profiles#index'
  resources :profile
  # get '/profile/:id', to: 'profiles#show'
  # post '/search', to: 'profiles#search'
  # post '/create', to: 'profiles#create'
  # get '/search?:value', to: 'profiles#search'
end
