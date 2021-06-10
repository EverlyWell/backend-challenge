class ApplicationController < ActionController::Base
  rescue_from ActionController::ParameterMissing do |exception|
    render json: { error: exception.message }, status: :bad_request
  end

  rescue_from ActiveRecord::RecordNotFound do
    render json: { error: 'Member not found' }, status: :not_found
  end
end
