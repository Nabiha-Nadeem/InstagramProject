# frozen_string_literal: true

Rails.application.routes.draw do
  root 'users#index'
  devise_for :users

  post 'search/user' => 'users#search', as: :search_user

  resources :requests, only: %i[create index update destroy]
  resources :follows, only: %i[create destroy]
  resources :users, only: %i[show index]

  resources :posts, only: %i[show create update destroy edit] do
    resources :comments, only: %i[edit create destroy update]
    resources :photos, only: [:create]
  end

  resources :stories, only: %i[show create destroy] do
    resource :photos, only: [:create]
  end

  resources :posts, :comments do
    resources :likes, only: %i[create destroy]
  end
end
