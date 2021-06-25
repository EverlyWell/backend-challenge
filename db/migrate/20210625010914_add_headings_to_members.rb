class AddHeadingsToMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :headings, :string
  end
end
