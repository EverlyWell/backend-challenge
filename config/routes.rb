Rails.application.routes.draw do
  jsonapi_resources :friendships
  jsonapi_resources :members
  get '/su/:member_id', to: 'members#short_url_redirect'
end
