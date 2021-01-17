# frozen_string_literal: true

module Members
  module Website
    class UrlShortenerService
      extend LightService::Organizer

      class << self
        def call(member)
          with(member: member).reduce(actions)
        end

        private

        def actions
          [
            UrlShortenerActions::GeneratePayload,
            UrlShortenerActions::InstantiateHTTPClient,
            UrlShortenerActions::ParseResponse,
            UrlShortenerActions::PersistShortUrl
          ]
        end
      end
    end
  end
end
