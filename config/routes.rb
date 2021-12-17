Rails.application.routes.draw do
  devise_for :members, controllers: { registrations: "member/registrations" }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "landing#show"

  resources :members, only: [:show, :index]
  resources :friendships, only: [:create]
end
