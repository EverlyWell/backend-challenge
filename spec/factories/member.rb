# frozen_string_literal: true

FactoryBot.define do
  factory :member do
    first_name { "Test" }
    last_name { "Member" }
    url { "http://www.example.com" }
  end
end
