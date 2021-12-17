class Friendship < ApplicationRecord
  belongs_to :member
  belongs_to :friend, class_name: 'Member'

  belongs_to :friendly, class_name: 'Member', foreign_key: :member_id
  belongs_to :friends, class_name: 'Member', foreign_key: :friend_id

  validate :not_relation_to_itself
  validates_uniqueness_of :member_id, scope: :friend_id

  def not_relation_to_itself
    if member_id == friend_id
      message = 'A member cannot create a friend with itself'

      errors.add(:friend, message)
    end
  end
end
