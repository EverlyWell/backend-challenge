class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.references :member
      t.references :friend

      t.timestamps
    end
  end
end
