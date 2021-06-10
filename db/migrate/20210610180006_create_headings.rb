class CreateHeadings < ActiveRecord::Migration[5.1]
  def change
    create_table :headings do |t|
      t.string :heading_type, default: ''
      t.string :text, default: ''
      t.references :member
      t.timestamps
    end
  end
end
