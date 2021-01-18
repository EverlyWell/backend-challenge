# frozen_string_literal: true

module Members
  module Website
    module UrlShortenerActions
      class ParseResponse
        extend LightService::Action

        expects :bitly_payload, :http_client
        promises :short_url

        executed do |ctx|
          resp = ctx.http_client.post do |req|
            req.body = ctx.bitly_payload
          end

          parse_response(resp, ctx)
        rescue Oj::ParseError => e
          ctx.fail_and_return!(
            "Unable to parse response: [#{e.message}",
            error_code: Website::URL_SHORTENER_SERVICE_ERRORS[:parsing_failed]
          )
        rescue Faraday::ConnectionFailed => e
          ctx.fail_and_return!(
            "Connection to Bit.ly failed: [#{e.message}",
            error_code: Website::URL_SHORTENER_SERVICE_ERRORS[:connection_failed]
          )
        end

        class << self
          private

          def parse_response(resp, ctx)
            if resp.status.between?(200, 201)
              parsed_response = Oj.load(resp.body)
              if (short_url = parsed_response['link'])
                ctx.short_url = short_url
              else
                ctx.fail_and_return!(
                  "Short URL link not found in response: [#{resp.status}] #{resp.body}",
                  error_code: Website::URL_SHORTENER_SERVICE_ERRORS[:short_url_missing]
                )
              end
            else
              ctx.fail_and_return!(
                "Short URL creation failed: [#{resp.status}] #{resp.body}",
                error_code: Website::URL_SHORTENER_SERVICE_ERRORS[:creation_failed]
              )
            end
          end
        end
      end
    end
  end
end
