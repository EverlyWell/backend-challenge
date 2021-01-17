# frozen_string_literal: true

module Members
  module Website
    module UrlShortenerActions
      class InstantiateHTTPClient
        extend LightService::Action

        BITLY_API_URL = 'https://api-ssl.bitly.com/v4/shorten'

        promises :http_client

        executed do |ctx|
          ctx.http_client = Faraday.new(
            url: BITLY_API_URL,
            headers: {
              'Content-Type' => 'application/json',
              'Authorization' => "Bearer #{Rails.application.credentials.bitly}"
            }
          )
        end
      end
    end
  end
end
