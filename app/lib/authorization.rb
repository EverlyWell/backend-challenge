# frozen_string_literal: true

class Authorization
  EXPIRATION_TIME = 24.hours

  JWT_HEADER_FIELDS = {
    typ: 'JWT',
    iss: 'Backend.Challenge'
  }.freeze

  JWT_ENCODING_ALGORITHM = 'HS512'

  JWT_OPTIONS = {
    algorithms: [JWT_ENCODING_ALGORITHM]
  }.freeze

  class << self
    def create_token(user)
      payload = {
        sub: user.id,
        name: user.name,
        exp: expiration_time
      }
      JWT.encode(
        payload,
        Rails.application.credentials.jwt_hmac_secret,
        JWT_ENCODING_ALGORITHM,
        JWT_HEADER_FIELDS
      )
    end

    def authorize!(jwt)
      decoded_payload = JWT.decode(
        jwt,
        Rails.application.credentials.jwt_hmac_secret,
        true,
        JWT_OPTIONS
      )
      user_id = decoded_payload.first['sub']
      User.find(user_id)
    end

    private

    def expiration_time
      (Time.zone.now.utc + EXPIRATION_TIME).to_i
    end
  end
end
