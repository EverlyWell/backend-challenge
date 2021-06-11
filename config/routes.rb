Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :members do
    resource :searches, only: :show
  end

  resources :friendships
end
