# frozen_string_literal: true

scope :api do
  namespace :v1 do
    post :authenticate, controller: :authentication, action: :create
  end
end
