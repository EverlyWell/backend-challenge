class Member < ApplicationRecord
  validates_presence_of :name, :personal_website_url
end
