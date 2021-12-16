describe 'Members', type: :request do
  let(:body) { JSON.parse(response.body) }

  describe 'creating a member' do
    subject { post '/members', params: params.to_json }

    context 'with valid params' do
      let(:params) do
        {
          member: {
            name: 'Sandi Metz',
            email: 'sandi@metz.com',
            personal_website_url: 'http://www.example.com'
          }
        }
      end

      it 'returns the correct status code' do
        subject
        expect(response).to have_http_status(:success)
      end
    end

    context 'with missing params' do
      let(:params) { {} }

      it 'returns the correct status code' do
        subject
        expect(response).not_to have_http_status(:success)
      end
    end
  end

  describe 'viewing all members' do
    subject { get '/members', headers: headers }

    it 'returns the correct status code' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'returns an array' do
      subject
      expect(body).to be_an_instance_of(Array)
    end
  end

  describe 'viewing a member' do
    context 'when member exists' do
      subject { get "/members/#{Member.first.id}", headers: headers }

      it 'returns the correct status code' do
        subject
        expect(response).to have_http_status(:success)
      end
    end

    context 'when member not fond' do
      subject { get '/members/0', headers: headers }

      it 'returns the correct status code' do
        subject
        expect(response).not_to have_http_status(:success)
      end
    end
  end
end