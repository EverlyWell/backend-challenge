# frozen_string_literal: true

class Member < ApplicationRecord
  validates :first_name, :last_name, :url, presence: true

  # I did not add an index to the `members.last_name` column. In a real
  # application you would have to consider adding an index to columns used like
  # this.
  scope :ordered, -> { order(last_name: :asc) }
end
