class BaseController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :unprocessable_entity

  private

  def record_not_found(exception)
    render json: exception.message, status: :not_found
  end

  def unprocessable_entity(exception)
    render json: exception.message, status: :unprocessable_entity
  end
end
