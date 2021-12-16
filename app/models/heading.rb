class Heading < ApplicationRecord
  validates_presence_of :name, :member

  belongs_to :member
end
