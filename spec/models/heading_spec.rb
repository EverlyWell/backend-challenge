require 'rails_helper'

RSpec.describe Heading, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:text) }
  end

  describe 'Relations' do
    it do
      is_expected.to belong_to(:member)
                      .with_foreign_key('member_id')
                      .inverse_of(:headings)
    end
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
