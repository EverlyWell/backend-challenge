describe 'Members', type: :request do
  let(:body) { JSON.parse(response.body) }
  let(:headers) { { "Accept" => "application/json", 'Content-Type' => 'application/json' } }
  let(:vcr_record_mode) { :none }

  describe 'creating a member' do
    subject { post '/members', params: params.to_json, headers: headers }

    context 'with valid params' do
      let(:params) do
        {
          member: {
            first_name: 'Sandi',
            last_name: 'Metz',
            url: 'http://www.example.com'
          }
        }
      end

      it 'returns the correct status code' do
        VCR.use_cassette("create_member_request", record: vcr_record_mode) do
          subject
          expect(response).to have_http_status(:success)
        end
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
    let!(:member) { create(:member) }

    context 'when member exists' do
      subject { get "/members/#{Member.first.id}", headers: headers }

      it 'returns the correct status code' do
        subject
        expect(response).to have_http_status(:success)
      end
    end

    context 'when member not found' do
      subject { get '/members/0', headers: headers }

      it 'returns the correct status code' do
        subject
        expect(response).not_to have_http_status(:success)
      end
    end
  end
end