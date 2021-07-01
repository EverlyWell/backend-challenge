FactoryBot.define do
  factory :member do
    first_name { "Ignacio" }
    last_name  { "Alonso" }
    url        { "https://ignacio.al/" }

    after(:build) do |obj| 
      obj.class.skip_callback(:create, :after, :scrape_info, raise: false)
      obj.class.skip_callback(:save, :after, :shorten_url, raise: false)
    end
  end
end
