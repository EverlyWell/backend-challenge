class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.references :member
      t.references :friend, foreign_key: { to_table: 'members' }
      t.timestamps
    end
  end
end
