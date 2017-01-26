Rails.application.routes.draw do
  resources :challenges do
    member do
      get 'solvers'
      post 'solve'
    end
  end
  resources :categories
  devise_for :users
  root to: 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
