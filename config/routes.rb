# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: :registrations }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount_roboto
  authenticate :admin_user do
    mount PgHero::Engine, at: "pghero"
  end
  resources :users, only: %i[index show] do
    resources :solutions, only: :index
    get :impersonate, on: :member
  end
  resources :challenges, only: %i[index show] do
    resources :solutions, only: %i[index create]
  end
  resources :solutions, only: :index
  resources :categories, only: %i[index show]
  resources :faqs, only: :index
  root to: "home#index"
  get "leaderboard", to: "leaderboard#index"
  get "policies", to: "policies#index"
  get "policies/privacy"
  get "policies/terms"
  get "faq", to: "faq#index"
  get "about", to: "about#index"
  get "chat", to: "chat#index"

  namespace :api do
    namespace :wechall do
      namespace :users do
        get "validate"
        get "score"
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
