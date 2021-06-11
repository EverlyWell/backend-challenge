class OptimizeSearch < ActiveRecord::Migration[5.1]
  def change
    remove_column :members, :search_column

    execute <<-SQL
      ALTER TABLE headings ADD COLUMN search_vector tsvector
    SQL
  end
end
