require 'open-uri'

class Member < ApplicationRecord
  validates :name, :url, presence: true

  has_many :headings
  before_create :shorten_url, :set_page_headings

  private

  def shorten_url
    response = HTTParty.post("https://firebasedynamiclinks.googleapis.com/v1/shortLinks",
                  query: { key: Rails.application.secrets.firebase_key },
                  headers: { 'Content-Type' => 'application/json' },
                  body: {
                    dynamicLinkInfo: {
                      domainUriPrefix: "https://backendchallenge.page.link",
                      link: url 
                    }
                  }.to_json)
    self.shortened_url = JSON.parse(response.body)["shortLink"]
  end

  def page_headings
    @doc ||= Nokogiri::HTML(HTTParty.get(url))
    @headings ||= @doc.css('h1, h2, h3').map { |heading| [heading.name, heading.text] }
  end

  def set_page_headings
    page_headings.each do |type, text|
      self.headings << Heading.new(heading_type: type, text: text)
    end
  end
end
