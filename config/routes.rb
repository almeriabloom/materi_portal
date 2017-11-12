TechReviewSite::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :users, only: :show 
  resources :products, only: :show do
    resources :reviews, only: [:new,:create]
    collection do
      get 'search'
    end
  end
  root 'products#index'

end
