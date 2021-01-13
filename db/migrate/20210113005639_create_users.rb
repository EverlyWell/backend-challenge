class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :login, null: false, index: { unique: true }, comment: "User login"
      t.string :password_digest, null: false, comment: "User password"
      t.text :name, null: false, comment: "The user's name"
      t.text :website_url, null: false, comment: "User's website URL"

      t.timestamps
    end
  end
end
