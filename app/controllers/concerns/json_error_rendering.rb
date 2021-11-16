module JsonErrorRendering
  extend ActiveSupport::Concern

  included do

    rescue_from ActionController::ParameterMissing do |exception|
      render json: { error: exception.message }, status: :bad_request
    end

    rescue_from ActiveRecord::RecordNotFound do |exception|
      render json: { error: exception.message }, status: :not_found
    end

  end
end