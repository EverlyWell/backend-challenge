class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.references :member, null: false, index: true, foreign_key: { to_table: :members }
      t.references :friend, null: false, index: true, foreign_key: { to_table: :members }

      t.timestamps
    end

    add_index :friendships, [:member_id, :friend_id], unique: true
  end
end
