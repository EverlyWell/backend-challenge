Rails.application.routes.draw do
  resources :members, only: %i[index show create]
end
