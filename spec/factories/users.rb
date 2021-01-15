FactoryBot.define do
  factory :user do
    sequence(:login) { |i| "random-joe-#{i}" }
    password { SecureRandom.hex }
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
