require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe Member, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_url_of(:url) }
  end

  describe 'Relations' do
    it do
      is_expected.to have_many(:headings)
                      .dependent(:destroy)
                      .inverse_of(:member)
    end
  end

  describe 'callbacks' do
    describe 'after create', :vcr do
      let(:member) { build(:member, url: 'https://nokogiri.org') }
      let(:expected_headings) do
        [
          'Nokogiri¶',
          'Guiding Principles¶',
          'Features Overview¶',
          'Status¶',
          'Support and Help¶',
          'Reading¶',
          'Questions¶',
          'Security and Vulnerability Reporting¶',
          'Semantic Versioning Policy¶',
          'Installation¶',
          'Native Gems: Faster, more reliable installation¶',
          'Supported Platforms¶',
          'Other Installation Options¶',
          'How To Use Nokogiri¶',
          'Parsing and Querying¶',
          'Encoding¶',
          'Technical Overview¶',
          'Guiding Principles¶',
          'CRuby¶',
          'JRuby¶',
          'Contributing¶',
          'Code of Conduct¶',
          'License¶',
          'Dependencies¶',
          'Authors¶'
        ]
      end
      let(:expected_short_url) { 'https://bit.ly/3qrL9iw' }

      before do
        Sidekiq::Testing.fake!
        allow(member).to receive(:enqueue_creation_jobs).and_call_original
        Sidekiq::Worker.clear_all

        member.save
        Sidekiq::Worker.drain_all
        member.reload
      end

      it "extracts the member's website headings" do
        expect(member.headings.size).to eq expected_headings.size
        expect(member.headings.pluck(:text)).to eq expected_headings
      end

      it "shortens the member's website URL" do
        expect(member.short_url).to be_present
        expect(member.short_url).to eq expected_short_url
      end
    end
  end
end

# ## Schema Information
#
# Table name: `members`
#
# ### Columns
#
# Name                                    | Type               | Attributes
# --------------------------------------- | ------------------ | ---------------------------
# **`id`**                                | `uuid`             | `not null, primary key`
# **`name(Name)`**                        | `text`             | `not null`
# **`short_url(Shortened website URL)`**  | `text`             |
# **`url(Website URL)`**                  | `text`             | `not null`
# **`created_at`**                        | `datetime`         | `not null`
# **`updated_at`**                        | `datetime`         | `not null`
#
