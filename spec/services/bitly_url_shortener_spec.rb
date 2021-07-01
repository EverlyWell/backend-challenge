describe BitlyUrlShortener do
  let(:member) { create(:member) }
  let(:vcr_record_mode) { :none }

  describe "#execute" do
    subject(:execute) do
      -> do
        VCR.use_cassette("bitly_shortener", record: vcr_record_mode) do
          described_class.execute(member)
        end
      end
    end

    it "creates a short_url for the member"  do
      is_expected.to change { member.short_url }.from(nil).to(
        'https://bit.ly/3wd8Opk'
      )
    end
  end
end
