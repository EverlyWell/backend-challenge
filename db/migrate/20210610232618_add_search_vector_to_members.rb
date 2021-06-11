class AddSearchVectorToMembers < ActiveRecord::Migration[5.1]
  def change
    execute <<-SQL
      ALTER TABLE members ADD COLUMN search_column tsvector
    SQL
  end
end
