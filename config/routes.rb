Rails.application.routes.draw do
  jsonapi_resources :friendships
  jsonapi_resources :members
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
