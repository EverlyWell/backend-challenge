class Member < ApplicationRecord
  has_many :headings

  validates :first_name, :last_name, :url, presence: true 

  after_create :scrape_info


  def scrape_info
    HeadingScraper.execute(self)
  end
end
