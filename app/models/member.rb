class Member < ApplicationRecord
  before_save :generate_profile_metadata, on: :create

  def generate_profile_metadata
    return unless url_changed?
    html = HTTParty.get(self.url, format: :plain)
    doc = Nokogiri::HTML::DocumentFragment.parse(html)
    self.profile_metadata = {
      'h1' => doc.css('h1').map(&:text),
      'h2' => doc.css('h2').map(&:text),
      'h3' => doc.css('h3').map(&:text)
    }
  end
end
