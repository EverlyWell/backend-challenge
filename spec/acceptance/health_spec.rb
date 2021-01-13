# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Health' do
  explanation 'Ping the service'

  header 'Accept', 'application/vnd.api+json'
  header 'Content-Type', 'application/json'

  get '/' do
    context '200' do
      example 'Ping' do
        do_request

        expect(status).to eq 200
        expect(response_body).to include_json(HealthController::PING_RESPONSE)
      end
    end
  end

  get 'health/ping' do
    context '200' do
      example 'Ping' do
        do_request

        expect(status).to eq 200
        expect(response_body).to include_json(HealthController::PING_RESPONSE)
      end
    end
  end

  head 'health/live' do
    context '200' do
      example 'Check service is live' do
        do_request

        expect(status).to eq 200
      end
    end
  end
end
