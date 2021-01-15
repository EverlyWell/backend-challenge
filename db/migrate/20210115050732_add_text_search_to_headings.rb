class AddTextSearchToHeadings < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      ALTER TABLE headings
        ADD COLUMN txt_tsearch tsvector GENERATED ALWAYS AS (
          setweight(to_tsvector('english', coalesce(text, '')), 'A')
        ) STORED;
    SQL
  end

  def down
    remove_column :headings, :txt_tsearch
  end
end
