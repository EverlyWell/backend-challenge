require 'rails_helper'

describe 'Friendships', type: :request do
  let(:body) { JSON.parse(response.body) }
  let(:headers) { { "Accept" => "application/json", 'Content-Type' => 'application/json' } }

  describe 'creating a friendship' do
    let(:member_one) { create(:member, first_name: "One") }
    let(:member_two) { create(:member, first_name: "Two") }

    subject { post '/friendships', params: params.to_json, headers: headers }

    context 'with valid params' do
      let(:params) do
        {
          friendship: {
            member_id: member_one.id,
            friend_id: member_two.id,
          }
        }
      end

      it 'returns the correct status code' do
        subject
        expect(response).to have_http_status(:success)
      end

      it 'saves the friendship member_one -> member_two' do
        subject
        new_friend = member_one.friendships.last.friend
        expect(new_friend).to eq member_two
      end

      it 'saves the inverse friendship member_two -> member_one' do
        subject
        new_friend = member_two.friendships.last.friend
        expect(new_friend).to eq member_one
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
