Rails.application.routes.draw do
  get 'comments/create'
  # get 'users/show'
  devise_for :users
  # get 'reviews/top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "reviews#top"
  resources :reviews do
    resources :comments
  end
  resources :users, only: [:show]
end
