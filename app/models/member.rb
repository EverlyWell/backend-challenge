class Member < ApplicationRecord
  validates :first_name, :last_name, :url, presence: true

  def shorten_url
    self.short_url = ShortUrl.new(url).shorten
  end
end
