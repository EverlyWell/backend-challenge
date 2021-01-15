class ChangeUserAttributes < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.remove :name
      t.remove :website_url
    end
  end
end
