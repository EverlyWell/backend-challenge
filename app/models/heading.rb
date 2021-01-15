class Heading < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_text,
                    against: :text,
                    using: {
                      tsearch: {
                        dictionary: 'english',
                        tsvector_column: 'txt_tsearch'
                      }
                    }

  validates :text, presence: true

  belongs_to :member, foreign_key: :member_id, inverse_of: :headings
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
