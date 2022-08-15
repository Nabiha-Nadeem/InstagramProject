# frozen_string_literal: true

Rails.application.routes.draw do
  root 'users#index'
  devise_for :users

  post 'follow/user/:id' => 'follows#follow_user', as: :follow_user
  delete 'unfollow/user' => 'follows#unfollow_user', as: :unfollow_user
  post 'request/user' => 'requests#create', as: :request_user
  post 'remove-request/user' => 'requests#remove_follow_request', as: :remove_request
  post 'search/user' => 'users#search', as: :search_user

  resources :follows, only: :create

  resources :requests

  resources :users, only: %i[show index]

  resources :posts, only: %i[show create update destroy edit] do
    resources :comments
    resources :likes, only: %i[create destroy]
    resources :photos, only: [:create]
  end

  resources :stories, only: %i[show create destroy] do
    resource :photos, only: [:create]
  end
end
