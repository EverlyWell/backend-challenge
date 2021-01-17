# frozen_string_literal: true

module Members
  module Website
    module HeadingExtractionActions
      class GetWebsite
        extend LightService::Action

        expects :member
        promises :html_doc

        executed do |ctx|
          resp = Faraday.get(ctx.member.url)
          ctx.html_doc = resp.body.to_s
        rescue Faraday::ConnectionFailed => e
          ctx.fail_and_return!(
            "Connection to member website URL failed: [#{e.message}",
            error_code: Website::HEADING_EXTRACTION_SERVICE_ERRORS[:connection_failed]
          )
        end
      end
    end
  end
end
