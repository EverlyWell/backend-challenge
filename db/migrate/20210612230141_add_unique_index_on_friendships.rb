class AddUniqueIndexOnFriendships < ActiveRecord::Migration[5.1]
  def change
    add_index :friendships, [:member_id, :friend_id], unique: true
  end
end
