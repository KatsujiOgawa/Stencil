Rails.application.routes.draw do
  get 'reviews/top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "reviews#top"
  resources :reviews
end
