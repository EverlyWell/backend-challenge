# frozen_string_literal: true

Rails.application.routes.draw do
  scope 'health', as: 'health', defaults: { format: :json } do
    get 'ping',    to: 'health#show',    as: :ping
    get 'live',    to: 'health#live',    as: :live
  end

  root 'health#show'
end
