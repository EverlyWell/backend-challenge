# frozen_string_literal: true

class UrlShortenerService
  attr_reader :access_token, :service_endpoint

  def initialize
    # Ideally we should get this token from config/secrets.yml.enc
    @access_token = "b936ad4db668c6fccd6e6955b8b744a67347663c"
    @service_endpoint = "https://api-ssl.bitly.com/v4/shorten"
  end

  def short_url_for(url)
    # I dont want to hit Bit.ly's service when running tests. Ideally we would
    # use a gem like VCR, that captures and replays requests to external APIs
    # when running your test suite.
    return "https://bit.ly/3vPFeWF" if Rails.env.test?

    result = RestClient.post(
      service_endpoint, { "long_url": url }.to_json, headers)
    JSON.parse(result)["link"]
  end

  private

  def headers
    {
      authorization: "Bearer #{access_token}",
      content_type: :json,
      accept: :json
    }
  end
end
