# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json }, path: '' do
    draw :v1
  end

  draw :health

  root 'health#show'
end
