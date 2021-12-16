class CreateHeadings < ActiveRecord::Migration[6.1]
  def change
    create_table :headings do |t|
      t.references :member, null: false
      t.string :name, null: false
      t.timestamps
    end
  end
end
