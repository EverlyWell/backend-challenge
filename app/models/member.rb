class Member < ApplicationRecord
  has_many :headings
  has_many :friendships, ->(member) do 
    where("member_id = ? OR friend_id = ?", member.id, member.id)
  end

  has_many :friends, through: :friendships

  validates :first_name, :last_name, :url, presence: true 

  after_create :scrape_info
  after_save :shorten_url, if: :saved_change_to_url?

  def scrape_info
    HeadingScraper.execute(self)
  end

  def shorten_url
    BitlyUrlShortener.execute(self)
  end
end
