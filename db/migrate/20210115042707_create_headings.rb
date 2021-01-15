class CreateHeadings < ActiveRecord::Migration[6.1]
  def change
    create_table :headings do |t|
      t.references :member, null: false, foreign_key: true, type: :uuid, comment: 'Member UUID'
      t.text :text, null: false, comment: 'Heading text'

      t.timestamps
    end
  end
end
