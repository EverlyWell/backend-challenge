describe HeadingScraper do
  let(:member) { create(:member) }
  let(:vcr_record_mode) { :none }

  describe "#execute" do
    subject(:execute) do
      -> do
          VCR.use_cassette("heading_scraper", record: vcr_record_mode) do
            described_class.execute(member)
          end
        end
    end

    it "creates 3 headings"  do
      is_expected.to change { Heading.count }.from(0).to(3)
    end

    it "scrapes the right information" do
      is_expected.to change { Heading.pluck(:content) }.from([]).to(
        ["Ignacio Alonso", "Projects", "Presentations"]
      )
    end
  end
end
