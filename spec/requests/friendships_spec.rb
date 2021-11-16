require 'rails_helper'

describe 'Friendships', type: :request do
  let(:body) { JSON.parse(response.body) }
  let(:headers) { { "Accept" => "application/vnd.api+json", 'Content-Type' => 'application/vnd.api+json' } }

  describe 'creating a friendship' do
    subject { post '/friendships', params: params.to_json, headers: headers }

    context 'with valid params' do
      let(:member1) { Member.create(first_name: 'Matt', last_name: 'Meyer', url: 'https://mmeyer.dev' )}
      let(:member2) { Member.create(first_name: 'Sandi', last_name: 'Metz', url: 'http://www.example.com' )}
      let(:params) do
        {
          friendship: {
            member_id: member1.id,
            friend_id: member2.id,
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