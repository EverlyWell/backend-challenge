FactoryBot.define do
  factory :heading do
    member
    text { "All work nO play makes JAck a dUll BOY" }
  end
end

# ## Schema Information
#
# Table name: `headings`
#
# ### Columns
#
# Name                          | Type               | Attributes
# ----------------------------- | ------------------ | ---------------------------
# **`id`**                      | `bigint`           | `not null, primary key`
# **`text(Heading text)`**      | `text`             | `not null`
# **`txt_tsearch`**             | `tsvector`         |
# **`created_at`**              | `datetime`         | `not null`
# **`updated_at`**              | `datetime`         | `not null`
# **`member_id(Member UUID)`**  | `uuid`             | `not null`
#
# ### Indexes
#
# * `index_headings_on_member_id`:
#     * **`member_id`**
# * `index_headings_on_txt_tsearch` (_using_ gin):
#     * **`txt_tsearch`**
#
# ### Foreign Keys
#
# * `fk_rails_60260ba0a3`:
#     * **`member_id => members.id`**
#
