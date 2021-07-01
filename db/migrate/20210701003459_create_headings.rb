class CreateHeadings < ActiveRecord::Migration[6.1]
  def change
    create_table :headings do |t|
      t.string :content
      t.references :member, null: false, foreign_key: true

      t.timestamps
    end

    add_index :headings, :content
  end
end
