class Friendship < ApplicationRecord
  belongs_to :member, class_name: 'Member'
  belongs_to :friend, class_name: 'Member'
end
