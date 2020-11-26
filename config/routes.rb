Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  get 'reviews/top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show]
  root to: "reviews#top"
  resources :reviews
end
