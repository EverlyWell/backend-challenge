# frozen_string_literal: true

scope 'health', as: 'health', defaults: { format: :json } do
  get 'ping',    to: 'health#show',    as: :ping
  get 'live',    to: 'health#live',    as: :live
end
