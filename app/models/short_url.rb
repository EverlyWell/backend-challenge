class ShortUrl
  attr_reader :client, :url

  def initialize(url)
    @client = Bitly::API::Client.new(token: Figaro.env.bitly_api_key)
    @url = url
  end

  def shorten
    client.shorten(long_url: url).link
  end
end
