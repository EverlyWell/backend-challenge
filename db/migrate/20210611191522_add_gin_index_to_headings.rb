class AddGinIndexToHeadings < ActiveRecord::Migration[5.1]
  def change
    add_index :headings, :search_vector, using: :gin
  end
end
