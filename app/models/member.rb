class Member < ApplicationRecord
  has_many :headings

  validates :first_name, :last_name, :url, presence: true 
end
