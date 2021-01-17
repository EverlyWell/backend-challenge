# frozen_string_literal: true

module Members
  module Website
    module UrlShortenerActions
      class PersistShortUrl
        extend LightService::Action

        expects :short_url, :member

        executed do |ctx|
          unless ctx.member.update(short_url: ctx.short_url)
            ctx.fail_and_return!(
              "Short URL not persisted: [#{ctx.memeber.errors&.full_messages}",
              error_code: Website::URL_SHORTENER_SERVICE_ERRORS[:short_url_persist_failed]
            )
          end
        end
      end
    end
  end
end
