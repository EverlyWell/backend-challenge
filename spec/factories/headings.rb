FactoryBot.define do
  factory :heading do
    content { "I write about ruby and rails" }
    association :member
  end
end
