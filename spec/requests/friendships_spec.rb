require 'rails_helper'

describe 'Friendships', type: :request do
  let(:body) { JSON.parse(response.body) }
  let(:headers) { { "Accept" => "application/json", 'Content-Type' => 'application/json' } }

  describe 'creating a friendship' do
    subject { post '/friendships', params: params.to_json, headers: headers }

    context 'with valid params' do
      let!(:member) { Member.create name: 'Member', url: 'https://member-page.com' }
      let!(:friend) { Member.create name: 'Friend', url: 'https://friend-page.com' }

      let(:params) do
        {
          friendship: {
            member_id: member.id,
            friend_id: friend.id,
          }
        }
      end


      it 'returns the correct status code' do
        subject
        expect(response).to have_http_status(:success)
      end
    end

    context 'with empty params' do
      let(:params) { {} }

      it 'returns the correct status code' do
        subject
        expect(response).not_to have_http_status(:success)
      end
    end
  end
end
