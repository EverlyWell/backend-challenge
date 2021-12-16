FactoryBot.define do
  factory :heading do
    name { Faker::Creature::Animal.name }
    member
  end
end
