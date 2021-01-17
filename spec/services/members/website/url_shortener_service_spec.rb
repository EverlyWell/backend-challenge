# frozen_string_literal: true

require 'rails_helper'

describe Members::Website::UrlShortenerService, :vcr do
  describe '.call' do
    let(:member) { create(:member) }
    let(:expected_short_url) { 'https://bit.ly/3p6wmK1' }

    subject { described_class.call(member) }

    context "when the member's website URL is shortened" do
      before do
        subject
      end

      it { is_expected.to be_success }

      it 'persists the short URL of the member' do
        member.reload
        expect(member.short_url).to be_present
        expect(member.short_url).to eq expected_short_url
      end
    end
  end
end
