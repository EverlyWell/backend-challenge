class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :url, null: false
      t.jsonb :profile_metadata
      t.timestamps
    end
  end
end
