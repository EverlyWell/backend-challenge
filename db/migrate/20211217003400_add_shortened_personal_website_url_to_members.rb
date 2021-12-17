class AddShortenedPersonalWebsiteUrlToMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :shortened_personal_website_url, :string, null: true
  end
end
