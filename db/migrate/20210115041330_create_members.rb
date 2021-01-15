class CreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members, id: :uuid do |t|
      t.text :name, null: false, comment: 'Name'
      t.text :url, null: false, comment: 'Website URL'
      t.text :short_url, comment: 'Shortened website URL'

      t.timestamps
    end
  end
end
