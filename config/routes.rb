require "sidekiq/web"

Rails.application.routes.draw do
  root to: "members#index"
  mount Sidekiq::Web => "/sidekiq"

  resources :members do
    resources :friendships, only: :destroy
    resource :searches, only: :show
    resource :url_data, only: :show
  end

  resources :friendships, only: :create
end
