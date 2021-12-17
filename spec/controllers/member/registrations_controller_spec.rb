describe Member::RegistrationsController, type: :controller do
  describe 'POST #create' do
    let(:params) do 
      {
        member: {
          name: 'Josh Comeau',
          email: 'hello@joshwcomeau.com',
          personal_website_url: 'https://www.joshwcomeau.com/',
          password: '123456',
          password_confirmation: '123456',
        }
      }
    end

    let(:post_create) do
      post :create, params: params
    end

    # Devise needs this to test directly the controller
    before do
      @request.env["devise.mapping"] = Devise.mappings[:member]

      # By allowing it first we tell rspec to spy on the method so we can test that it 
      # was called later.
      # We also get desirable side effect of the actual method not being called so we don't
      # need to wrap these calls with VCR
      allow(HeadingsPullerJob).to receive(:perform_async)
      allow(UrlShortnerJob).to receive(:perform_async)
    end

    it 'creates a member' do
      expect { post_create }.to change { Member.count }.by 1
    end

    it 'calls the headings_puller_job' do
      post_create

      expect(HeadingsPullerJob).to have_received(:perform_async)
    end

    it 'calls the url shortner job' do
      post_create

      expect(UrlShortnerJob).to have_received(:perform_async)
    end
  end
end
