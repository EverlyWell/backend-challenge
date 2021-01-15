require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:user) { build(:user) }

    it { is_expected.to validate_presence_of(:login) }
    it { expect(user).to validate_uniqueness_of(:login) }
    it { is_expected.to validate_presence_of(:password) }
  end
end

# ## Schema Information
#
# Table name: `users`
#
# ### Columns
#
# Name                                  | Type               | Attributes
# ------------------------------------- | ------------------ | ---------------------------
# **`id`**                              | `uuid`             | `not null, primary key`
# **`login(User login)`**               | `string`           | `not null`
# **`password_digest(User password)`**  | `string`           | `not null`
# **`created_at`**                      | `datetime`         | `not null`
# **`updated_at`**                      | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_users_on_login` (_unique_):
#     * **`login`**
#
