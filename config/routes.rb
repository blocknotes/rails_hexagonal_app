# frozen_string_literal: true

Rails.application.routes.draw do
  resources :authors, only: %i[show]

  resources :posts do
    collection do
      get :export
    end

    member do
      post :publish
    end
  end

  root 'posts#index'
end
