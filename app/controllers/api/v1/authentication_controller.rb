# frozen_string_literal: true

module Api
  module V1
    class AuthenticationController < ApplicationController
      def create
        jwt = Authentication.authenticate(auth_params[:username], auth_params[:password])

        if jwt
          render json: { token: jwt }, status: :created
        else
          render_app_error_code(code_id: '666')
        end
      end

      private

      def auth_params
        params.permit(:username, :password)
      end
    end
  end
end
