# frozen_string_literal: true

class Authentication
  class << self
    def authenticate(username, password)
      user = User.find_by(login: username)

      Authorization.create_token(user) if user&.authenticate(password)
    end
  end
end
