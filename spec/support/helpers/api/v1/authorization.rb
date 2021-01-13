# frozen_string_literal: true

module Helpers
  module Api
    module V1
      def authorization_header(client)
        { 'Authorization' => jwt_bearer_token(client) }
      end

      def jwt_bearer_token(client)
        jwt = ::Authorization.create_token(client)
        "Bearer #{jwt}"
      end
    end
  end
end
