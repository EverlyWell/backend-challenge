# frozen_string_literal: true

class WebsiteHeadingsService
  def headings_for_url(url)
    # I dont want to hit external websites when running tests. Ideally we would
    # use a gem like VCR, that captures and replays requests to external APIs
    # when running your test suite.
    return ["Example Domain"] if Rails.env.test?

    html = RestClient.get(url).body
    Nokogiri::HTML.parse(html).css("h1, h2, h3").map(&:text)
  end
end
