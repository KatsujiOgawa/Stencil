Rails.application.routes.draw do
  get 'comments/create'
  # get 'users/show'
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users#new_guest'
  end
  # get 'reviews/top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "reviews#top"
  resources :reviews do
    collection do
      get 'search'
    end
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:show]
  resources :relationships, only: [:create, :destroy]
end
