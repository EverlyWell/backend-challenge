FactoryBot.define do
  factory :member do
    first_name { "Ignacio" }
    last_name  { "Alonso" }
    url        { "https://ignacio.al/" }

    after(:build) { |obj| obj.class.skip_callback(:create, :after, :scrape_info, raise: false) }
  end
end
