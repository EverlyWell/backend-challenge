# frozen_string_literal: true

require 'rails_helper'

describe JWTAuthorizationController, type: :request do
  class TestController < JWTAuthorizationController
    def index; end
  end

  before do
    Rails.application.routes.draw do
      get '/test', to: 'test#index'
    end
  end

  describe 'callbacks' do
    describe '#authorize!' do
      context 'when the JWT is malformed' do
        it 'is unauthorized and returns an error message' do
          get '/test', headers: { 'Authorization' => '' }

          expect(response).to have_http_status(:unauthorized)
          expect(JSON.parse(response.body)).to eq({ 'errors' => 'Malformed token' })
        end
      end

      context 'when the JWT uses a wrong token' do
        it 'is unauthorized and returns an error message' do
          get '/test',
              headers: { 'Authorization' => 'Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWUsImlhdCI6MTUxNjIzOTAyMn0.VFb0qJ1LRg_4ujbZoRMXnVkUgiuKq5KxWqNdbKq_G9Vvz-S1zZa9LPxtHWKa64zDl2ofkT8F6jBt_K4riU-fPg' }

          expect(response).to have_http_status(:unauthorized)
          expect(JSON.parse(response.body)).to eq({ 'errors' => 'Token could not be verified' })
        end
      end

      context 'when the JWT is expired' do
        it 'is unauthorized and returns an error message' do
          payload = {
            sub: 123_456,
            name: 'Foo',
            exp: (Time.zone.now.utc - 3.days).to_i
          }

          jwt = JWT.encode(payload, ENV['JWT_HMAC_SECRET'], 'HS512')
          get '/test', headers: { 'Authorization' => "Bearer #{jwt}" }

          expect(response).to have_http_status(:unauthorized)
          expect(JSON.parse(response.body)).to eq({ 'errors' => 'Token has expired' })
        end
      end
    end
  end
end
