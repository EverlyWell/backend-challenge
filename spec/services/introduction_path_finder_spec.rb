require 'rails_helper'

RSpec.describe IntroductionsPathFinder do
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
  end

  describe "#adjacency_list" do
    it "calculates the adjacency list correctly" do
      member1 = Member.create(name: 'member1', url: 'https://nokogiri.org')
      member2 = Member.create(name: 'member2', url: 'https://nokogiri.org')
      member3 = Member.create(name: 'member3', url: 'https://nokogiri.org')
      member4 = Member.create(name: 'member4', url: 'https://nokogiri.org')
      member5 = Member.create(name: 'member5', url: 'https://nokogiri.org')
      member6 = Member.create(name: 'member6', url: 'https://nokogiri.org')
      member7 = Member.create(name: 'member7', url: 'https://nokogiri.org')

      member1.follow(member2)
      member1.follow(member3)
      member2.follow(member4)
      member3.follow(member4)
      member3.follow(member5)
      member5.follow(member6)
      member5.follow(member7)

      finder = IntroductionsPathFinder.new(member1)
      expect(finder.adjacency_list).to eq({
        member1.id => [member2.id, member3.id],
        member2.id => [member1.id, member4.id],
        member3.id => [member1.id, member4.id, member5.id],
        member4.id => [member2.id, member3.id],
        member5.id => [member3.id, member6.id, member7.id],
        member6.id => [member5.id],
        member7.id => [member5.id]
      })
    end
  end

  describe "#path_to" do
    it "calculates introduction path" do
      member1 = Member.create(name: 'member1', url: 'https://nokogiri.org')
      member2 = Member.create(name: 'member2', url: 'https://nokogiri.org')
      member3 = Member.create(name: 'member3', url: 'https://nokogiri.org')
      member4 = Member.create(name: 'member4', url: 'https://nokogiri.org')
      member5 = Member.create(name: 'member5', url: 'https://nokogiri.org')
      member6 = Member.create(name: 'member6', url: 'https://nokogiri.org')
      member7 = Member.create(name: 'member7', url: 'https://nokogiri.org')

      member1.follow(member2)
      member1.follow(member3)
      member2.follow(member4)
      member3.follow(member4)
      member3.follow(member5)
      member5.follow(member6)
      member5.follow(member7)

      finder = IntroductionsPathFinder.new(member1)
      finder.find_paths
      expect(finder.path_to(member6).map(&:name)).to eq ['member3', 'member5', 'member6']

      finder = IntroductionsPathFinder.new(member2)
      finder.find_paths

      expect(finder.path_to(member7).map(&:name)).to eq ['member4', 'member3', 'member5', 'member7']
    end
  end
end
