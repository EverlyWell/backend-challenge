require 'rails_helper'

RSpec.describe Member, type: :model do
  it 'can short its url with bitly' do
    allow_any_instance_of(ShortUrl).to receive(:shorten).and_return("https://bit.ly/3lLqPJQ")
    member = Member.create(first_name: "Ignacio", last_name: "Mella", url: "http://www.imella.com")
    member.shorten_url
    member.save

    expect(member.short_url).to eq("https://bit.ly/3lLqPJQ")
  end
end
