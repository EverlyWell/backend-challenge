class ApplicationController < ActionController::Base
  # We have overriden the devise registration view with additional fields that need to params permit
  before_action :permit_extra_devise_fields, if: :devise_controller?

  protected

  def permit_extra_devise_fields
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :personal_website_url])
  end
end
