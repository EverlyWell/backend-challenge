describe HeadingsPullerJob do
  describe '#perform' do
    # Pick the url of a content creator, a blog is ideal
    let(:personal_website_url) { 'https://www.joshwcomeau.com/' }
    let(:member)               { create(:member, personal_website_url: personal_website_url) }
    let(:vcr_mode)             { :new_episodes } # :all, :none, :new_episodes
    let(:vcr_cassette)         { :successfull_headings_puller_job }

    subject do
      VCR.use_cassette(vcr_cassette, record: vcr_mode) do
        described_class.perform_async(member.id)
      end
    end

    it 'creates a heading for each h1,h2,h3 elements on the page' do
      member_personal_website_headings_count = 25

      expect { subject }.to change { Heading.count }.to(member_personal_website_headings_count)
    end

    it 'creates a heading for each h1,h2,h3 elements on the page' do
      subject

      expect(member.headings.map(&:name)).to eql [
        "Josh W Comeau homepage",
        "Recently Published",
        "My Custom CSS Reset",
        "Introducing “Shadow Palette Generator”",
        "Designing Beautiful Shadows in CSS",
        "An Interactive Guide to Keyframe Animations",
        "The World of CSS Transforms",
        "How To Learn Stuff Quickly",
        "Demystifying styled-components",
        "How I Built My Blog",
        "Building a Magical 3D Button",
        "The Importance of Learning CSS",
        "What The Heck, z-index??",
        "An Interactive Guide to CSS Transitions",
        "The styled-components Happy Path",
        "Let's Bring Spacer GIFs Back!",
        "2020 In Review",
        "Refreshing Server-Side Props",
        "The Rules of Margin Collapse",
        "Boop!",
        "Chasing the Pixel-Perfect Dream",
        "Hands-Free Coding",
        "Top Categories",
        "Popular Content",
        "A front-end web development newsletter that sparks joy"
      ]
    end
  end
end
