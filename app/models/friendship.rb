class Friendship < ApplicationRecord
  validates :member_id, uniqueness: { scope: :friend_id }

  belongs_to :member, class_name: 'Member'
  belongs_to :friend, class_name: 'Member'
end
