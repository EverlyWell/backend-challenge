class BitlyUrlShortener
  include Executable

  def initialize(member)
    @member = member
  end

  def execute
    bitlink = client.shorten(long_url: member.url).link

    @member.update(short_url: bitlink)
  end

  private 

  attr_reader :member

  def client
    @client ||= Bitly::API::Client.new(token: ENV["BITLY_TOKEN"])
  end
end