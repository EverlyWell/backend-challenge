class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.string :name, null: false, default: ''
      t.string :url, null: false, default: ''
      t.string :shortened_url, default: ''
      t.text :page_headings, default: ''
      t.integer :friend_count, default: 0

      t.timestamps
    end
  end
end
