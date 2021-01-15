class AddTextSearchIdxToHeadings < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_index :headings, :txt_tsearch, using: :gin, algorithm: :concurrently
  end
end
