# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users

  resources :users, only: [:show]

  resources :posts, only: %i[index show create update destroy edit] do
    resources :photos, only: [:create]
  end
end
