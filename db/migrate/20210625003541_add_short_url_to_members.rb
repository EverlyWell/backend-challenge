class AddShortUrlToMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :short_url, :string
  end
end
