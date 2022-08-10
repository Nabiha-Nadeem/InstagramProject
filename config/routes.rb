# frozen_string_literal: true

Rails.application.routes.draw do
  root 'users#index'
  devise_for :users

  post 'follow/user' => 'users#follow_user', as: :follow_user
  delete 'unfollow/user' => 'users#unfollow_user', as: :unfollow_user

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
