require 'rails_helper'

RSpec.describe Member, type: :model do
	it "shortens the url and gets the page headings on model creation" do
		stub_request(:post, "https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=firebase_key")
      .to_return({
        body: {
          "shortLink": "https://backendchallenge.page.link/3hNAQkhbKcxKfFYH8"
        }.to_json
      })

    stub_request(:get, "https://pganalyze.com/blog/full-text-search-ruby-rails-postgres")
      .to_return({
        body: File.new('spec/models/full-text-search-ruby-rails-postgres')
      })

    member = Member.create name: 'Leigh Halliday', url: 'https://pganalyze.com/blog/full-text-search-ruby-rails-postgres'
    expect(member.shortened_url).to eq "https://backendchallenge.page.link/3hNAQkhbKcxKfFYH8"
    expect(member.headings.pluck(:heading_type, :text)).to eq([
      ["h1", "Full Text Search in Milliseconds with Rails and PostgreSQL"],
      ["h2", "The Foundations of Full Text Search"],
      ["h2", "Implementing Postgres Full Text Search in Rails"],
      ["h2", "Configuring pg_search"],
      ["h2", "Optimizing Full Text Search Queries in Rails"],
      ["h2", "Conclusion"],
      ["h2", "You might also be interested in"],
      ["h2", "About the author"],
      ["h3", "Sign up for the pganalyze newsletter"],
      ["h3", "Get in touch"]
    ])
  end
end
