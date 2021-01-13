# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'
require_relative '../../../support/helpers/api/v1/authorization'

resource 'Authentication' do
  include Helpers::Api::V1

  let(:user) { create(:user) }
  let(:jwt) { Authorization.create_token(user) }

  explanation 'User authentication'

  post '/api/v1/authenticate' do
    with_options with_example: true do
      parameter :username, 'user username', required: true
      parameter :password, 'user account password', required: true
    end

    context '201' do
      let(:username) { user.login }
      let(:password) { user.password }
      let!(:expected_response) { { token: jwt } }

      example 'Authenticates with the given credentials' do
        do_request
        expect(response_body).to include_json(expected_response)
        expect(status).to eq 201
      end
    end

    context '401' do
      context 'with empty credentials' do
        let(:username) { nil }
        let(:password) { nil }
        let(:expected_response) do
          {
            errors: [
              {
                code: '666',
                detail: 'Wrong username or password.',
                status: 'unauthorized',
                title: 'Wrong authentication credentials'
              }
            ]
          }
        end

        example 'Returns an error message when credentials are missing' do
          do_request
          expect(response_body).to include_json(expected_response)
          expect(status).to eq 401
        end
      end

      context 'with bad username' do
        let(:username) { 'not_a_user' }
        let(:password) { nil }
        let(:expected_response) do
          {
            errors: [
              {
                code: '666',
                detail: 'Wrong username or password.',
                status: 'unauthorized',
                title: 'Wrong authentication credentials'
              }
            ]
          }
        end

        example 'Returns an error message when credentials are missing' do
          do_request
          expect(response_body).to include_json(expected_response)
          expect(status).to eq 401
        end
      end

      context 'with bad password' do
        let(:username) { user.login }
        let(:password) { 'bad password' }

        let(:expected_response) do
          {
            errors: [
              {
                code: '666',
                detail: 'Wrong username or password.',
                status: 'unauthorized',
                title: 'Wrong authentication credentials'
              }
            ]
          }
        end

        example 'Returns an error message when credentials are missing' do
          do_request
          expect(response_body).to include_json(expected_response)
          expect(status).to eq 401
        end
      end
    end
  end
end
