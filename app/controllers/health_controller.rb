# frozen_string_literal: true

class HealthController < ApplicationController
  PING_RESPONSE = {
    data: {
      id: nil,
      type: 'ping',
      attributes: {
        message: 'PONG',
        alive: true
      }
    }
  }.freeze

  def show
    render json: PING_RESPONSE, status: :ok
  end

  def live
    head :ok
  end
end
