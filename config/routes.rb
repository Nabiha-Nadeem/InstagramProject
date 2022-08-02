# frozen_string_literal: true

Rails.application.routes.draw do
  root 'users#index'
  devise_for :users

  resources :users, only: %i[show index]

  resources :posts, only: %i[show create update destroy edit] do
    resources :photos, only: [:create]
  end

  resources :stories, only: %i[show create destroy] do
    resource :photos, only: [:create]
  end
end
