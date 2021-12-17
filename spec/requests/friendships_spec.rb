describe 'Friendships', type: :request do
  let(:headers) { { "Accept" => "application/json", 'Content-Type' => 'application/json' } }
  let(:logged_in_member) { create(:member) }

  before do
    sign_in logged_in_member, scope: :member
  end

  describe 'creating a friendship' do
    subject { post '/friendships', params: params.to_json, headers: headers }

    context 'with valid params' do
      let(:params) do
        {
          friendship: {
            member_id: create(:member).id,
            friend_id: create(:member).id,
          }
        }
      end

      it 'returns the correct status code' do
        subject
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'with empty params' do
      let(:params) { {} }

      it 'returns the correct status code' do
        expect { subject }.to raise_error { ActionController::ParameterMissing }
      end
    end
  end
end
