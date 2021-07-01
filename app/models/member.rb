class Member < ApplicationRecord
  validates :first_name, :last_name, :url, presence: true 
end
