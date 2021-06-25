Rails.application.routes.draw do
  resources :members, only: %i[index show new create]
  resources :friendships, only: %i[create]
  root to: "members#index"
end
