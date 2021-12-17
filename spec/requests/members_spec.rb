describe 'Members', type: :request do
  let(:logged_in_member) { create(:member) }

  before do
    sign_in logged_in_member, scope: :member
  end

  describe 'creating a member' do
    subject { post '/members', params: params.to_json }

    context 'with valid params' do
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

      it 'returns the correct status code' do
        subject
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'viewing all members' do
    subject { get '/members' }

    it 'returns the correct status code' do
      subject
      expect(response).to have_http_status(:success)
    end
  end

  describe 'viewing a member' do
    context 'when member exists' do
      let(:member) { create(:member) }

      subject { get "/members/#{member.id}", headers: headers }

      it 'returns the correct status code' do
        subject
        expect(response).to have_http_status(:success)
      end
    end

    context 'when member not fond' do
      subject { get '/members/0', headers: headers }

      it 'returns the correct status code' do
        expect{ subject }.to raise_error { ActiveRecord::RecordNotFound }
      end
    end
  end
end
