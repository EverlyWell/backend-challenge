# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :member
  belongs_to :friend, class_name: "Member"

  after_create :create_inverse_friendship

  private

  # This is my quick solution to make friendships bi-directional. It is not the
  # most efficient one since we need double the number of records in the table.
  def create_inverse_friendship
    return if Friendship.exists?(member_id: friend_id, friend_id: member_id)

    Friendship.create!(member_id: friend_id, friend_id: member_id)
  end
end
