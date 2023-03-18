Rails.application.routes.draw do
  get 'cards/new'
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  resources :cards, only: [:new, :create]
  root to: 'items#index'
  resources :items do
    resources :orders, only: [:index, :create]
    collection do
      get 'search'
    end
  end
end
