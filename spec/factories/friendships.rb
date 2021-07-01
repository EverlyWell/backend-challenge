FactoryBot.define do
  factory :friendship do
    association :member
    association :friend, factory: :member
  end
end
