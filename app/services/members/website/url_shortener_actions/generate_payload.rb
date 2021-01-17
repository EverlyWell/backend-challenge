# frozen_string_literal: true

module Members
  module Website
    module UrlShortenerActions
      class GeneratePayload
        extend LightService::Action

        expects :member
        promises :bitly_payload

        executed do |ctx|
          ctx.bitly_payload = Oj.dump(
            {
              'long_url' => ctx.member.url,
              'domain' => 'bit.ly'
            }
          )
        end
      end
    end
  end
end
