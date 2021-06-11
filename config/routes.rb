require "sidekiq/web"

Rails.application.routes.draw do
  root to: "members#index"
  mount Sidekiq::Web => "/sidekiq"

  resources :members do
    resource :searches, only: :show
    resource :url_data, only: :show
  end

  resources :friendships
end
