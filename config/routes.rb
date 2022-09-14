# frozen_string_literal: true

Rails.application.routes.draw do
  root 'users#index'
  devise_for :users
  post 'search/user' => 'users#search', as: :search_user
  resources :pages do
    post 'add_role' => 'pages#add_role', as: :add_role
  end
  resources :relationships, only: %i[create destroy]

  resources :requests, only: %i[create index update destroy]
  resources :follows, only: %i[create destroy]
  resources :users, only: %i[show index]

  concern :imageable do
    resources :photos, only: [:new]
  end

  concern :likeable do
    resources :likes, only: %i[create destroy]
  end

  resources :posts, only: %i[show create update destroy edit], concerns: %i[imageable likeable] do
    resources :comments, only: %i[edit create destroy update]
  end

  resources :comments, only: %i[edit create destroy update], concerns: :likeable
  resources :stories, only: %i[show create destroy], concerns: :imageable

  resources :subscriptions, only: %i[new create index]
end
