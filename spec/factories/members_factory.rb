FactoryBot.define do
  factory :member do
    email { Faker::Internet.email }
    password { SecureRandom.hex }
    name { Faker::Name.name }
    personal_website_url { 'https://about.me/grillermo/' }
  end
end

