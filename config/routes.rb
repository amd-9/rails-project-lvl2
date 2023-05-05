# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users

  resources :posts, only: %i[index show new create] do
    resources :comments, only: [:create]
    resources :likes, only: %i[create destroy]
  end
end
