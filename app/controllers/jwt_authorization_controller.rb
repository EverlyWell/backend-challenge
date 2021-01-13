# frozen_string_literal: true

class JWTAuthorizationController < ApplicationController
  before_action :authorize!

  attr_reader :current_user

  private

  def authorize!
    auth_token = extract_auth_token_from_header(request.headers['Authorization'])
    @current_user = ::Authorization.authorize!(auth_token)
  rescue JWT::VerificationError
    render_api_errors(errors: I18n.t('api.authorization.jwt.errors.verification'), status: :unauthorized)
  rescue JWT::ExpiredSignature
    render_api_errors(errors: I18n.t('api.authorization.jwt.errors.expired_signature'), status: :unauthorized)
  rescue JWT::DecodeError
    render_api_errors(errors: I18n.t('api.authorization.jwt.errors.malformed'), status: :unauthorized)
  end

  def extract_auth_token_from_header(authorization_header)
    authorization_header&.split(' ')&.last
  end
end
