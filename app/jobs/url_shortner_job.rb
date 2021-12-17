require 'net/http'

class UrlShortnerJob < ApplicationJob
  API_URL = 'http://chiq.me/'

  def perform(member_id)
    member = Member.find(member_id)

    shortened_url = shorten_url(member.personal_website_url)

    save_shortened_url(member, shortened_url)
  end

  def shorten_url(url)
    response = call_shortener_api(url)

    response.body
  end

  def save_shortened_url(member, url)
    member.update(shortened_personal_website_url: url)
  end

  # Request (POST )
  def call_shortener_api(url)
    uri = URI(API_URL)

    # Create client
    http = Net::HTTP.new(uri.host, uri.port)
    data = {
      "password" => Rails.application.secrets[:chiq_me_password],
      "url" => url,
    }
    body = URI.encode_www_form(data)

    # Create Request
    req =  Net::HTTP::Post.new(uri)
    # Add headers
    req.add_field "api", "true"
    # Add headers
    req.add_field "Content-Type", "application/x-www-form-urlencoded; charset=utf-8"
    # Set body
    req.body = body

    # Fetch Request
    res = http.request(req)
    res
  rescue StandardError => e
    puts "HTTP Request failed (#{e.message})"
  end
end
