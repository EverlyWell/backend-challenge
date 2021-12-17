describe UrlShortnerJob do
  describe '#perform' do
    # Pick the url of a content creator, a blog is ideal
    let(:personal_website_url) { 'https://www.joshwcomeau.com/' }
    let(:member)               { create(:member, personal_website_url: personal_website_url) }
    let(:vcr_mode)             { :new_episodes } # :all, :none, :new_episodes
    let(:vcr_cassette)         { :successfull_url_shortner_job }

    subject do
      VCR.use_cassette(vcr_cassette, record: vcr_mode) do
        described_class.perform_async(member.id)
      end
    end

    it 'creates a heading for each h1,h2,h3 elements on the page' do
      shortened_url = 'http://chiq.me/wvww'

      expect { subject }.to change { member.reload.shortened_personal_website_url }.to(
        shortened_url
      )
    end
  end
end
