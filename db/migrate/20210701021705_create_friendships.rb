class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.references :member, null: false, foreign_key: true
      t.bigint :friend_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
