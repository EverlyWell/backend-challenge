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
    end

    it 'creates a member' do
      expect { post_create }.to change { Member.count }.by 1
    end

    it 'calls the headings_puller_job' do
      expect(HeadingsPullerJob).to receive(:perform_async)

      post_create
    end
  end
end
