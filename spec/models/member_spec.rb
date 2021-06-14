require 'rails_helper'

RSpec.describe Member, type: :model do
  before do
    stub_request(:post, "https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=firebase_key")
      .to_return({
        body: {
          "shortLink": "https://backendchallenge.page.link/3hNAQkhbKcxKfFYH8"
        }.to_json
      })

    stub_request(:get, "https://nokogiri.org")
      .to_return({
        body: File.new('spec/models/nokogiri')
      })

    stub_request(:get, "https://pganalyze.com/blog/full-text-search-ruby-rails-postgres")
      .to_return({
        body: File.new('spec/models/full-text-search-ruby-rails-postgres')
      })
  end

  describe "#process_url" do
    it "shortens the url and gets the page headings on model creation" do
      member = Member.create name: 'Leigh Halliday', url: 'https://pganalyze.com/blog/full-text-search-ruby-rails-postgres'
      member.process_url
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

  describe "#follow" do
    it "adds a friend to both members" do
      member1 = Member.create name: 'Leigh Halliday', url: 'https://pganalyze.com/blog/full-text-search-ruby-rails-postgres'
      member2 = Member.create name: 'Nokogiri', url: 'https://nokogiri.org/'

      member1.follow(member2)
      member2.reload

      expect(member1.friends).to eq [member2]
      expect(member1.friend_count).to eq 1
      expect(member2.friends).to eq [member1]
      expect(member2.friend_count).to eq 1
    end

    it "doesn't throw if you try to follow the same user" do
      member1 = Member.create name: 'Leigh Halliday', url: 'https://pganalyze.com/blog/full-text-search-ruby-rails-postgres'
      member2 = Member.create name: 'Nokogiri', url: 'https://nokogiri.org/'

      member1.follow(member2)
      member1.follow(member2)

      expect(member1.reload.friend_count).to eq 1
      expect(member2.reload.friend_count).to eq 1
    end
  end

  describe "#unfollow" do
    it "adds a friend to both members" do
      member1 = Member.create name: 'Leigh Halliday', url: 'https://pganalyze.com/blog/full-text-search-ruby-rails-postgres'
      member2 = Member.create name: 'Nokogiri', url: 'https://nokogiri.org/'

      member1.follow(member2)
      member2.unfollow(member1)

      expect(member1.reload.friends).to eq []
      expect(member1.friend_count).to eq 0
      expect(member2.reload.friends).to eq []
      expect(member2.friend_count).to eq 0
    end

    it "doesn't throw if you try to unfollow a user you are not following" do
      member1 = Member.create name: 'Leigh Halliday', url: 'https://pganalyze.com/blog/full-text-search-ruby-rails-postgres'
      member2 = Member.create name: 'Nokogiri', url: 'https://nokogiri.org/'

      member1.unfollow(member2)

      expect(member1.reload.friend_count).to be_zero
      expect(member2.reload.friend_count).to be_zero
    end
  end

  describe "#non_followers" do
    it "returns members that are not followers" do
      member1 = Member.create name: 'Member 1', url: 'https://pganalyze.com/blog/full-text-search-ruby-rails-postgres'
      member2 = Member.create name: 'Member 2', url: 'https://pganalyze.com/blog/full-text-search-ruby-rails-postgres'
      member3 = Member.create name: 'Member 3', url: 'https://pganalyze.com/blog/full-text-search-ruby-rails-postgres'
      member4 = Member.create name: 'Member 4', url: 'https://pganalyze.com/blog/full-text-search-ruby-rails-postgres'

      member1.follow(member2)
      member2.follow(member3)

      expect(member1.non_followers).to match_array [member3, member4]
      expect(member2.non_followers).to match_array [member4]
      expect(member3.non_followers).to match_array [member1, member4]
      expect(member4.non_followers).to match_array [member1, member2, member3]
    end

  end

  describe "#search" do
    skip "runs efficiently" do
      member1 = Member.create name: 'Member 1', url: 'https://pganalyze.com/blog/full-text-search-ruby-rails-postgres'
      member1.process_url

      2.upto(1000) do |n|
        m = Member.create name: 'Member #{n}', url: 'https://pganalyze.com/blog/full-text-search-ruby-rails-postgres'
        m.process_url

        member1.follow(m) if n.even?
      end

      f = Tempfile.new('explain')
      json_plan = member1.search_query('Full text search').explain(analyze: true, format: :json).split("\n")
      f.write(json_plan.slice(1, json_plan.length).join("\n"))
      f.close
    end
  end
end
