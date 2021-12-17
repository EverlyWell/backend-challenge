require 'open-uri'
require 'net/http'

class HeadingsPullerJob < ApplicationJob
  def perform(member_id)
    member = Member.find(member_id)

    personal_website = load_personal_website(member.personal_website_url)

    headings_names = parse_headings(personal_website)

    save_headings(member, headings_names)
  end

  def load_personal_website(url)
    # the url might redirect to somewhere so we want to follow it first
    url = follow_redirect(url)

    page = open(url).read

    Nokogiri.parse(page)
  end

  def parse_headings(personal_website)
    target = 'h1,h2,h3'
    headings = personal_website.css(target)

    headings.map(&:text)
  end

  def save_headings(member, headings_names)
    headings_names.each do |name|
      Heading.create!(member: member, name: name)
    end
  end

  def follow_redirect(url)
    response = Net::HTTP.get_response(URI(url))

    location = response['location']

    if location.nil?
      return url
    else
      follow_redirect(location)
    end
  end
end
