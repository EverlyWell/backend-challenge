require 'rails_helper'

describe 'Members', type: :request do
  let(:body) { JSON.parse(response.body) }
  let(:headers) { { "Accept" => "application/vnd.api+json", 'Content-Type' => 'application/vnd.api+json' } }

  describe 'creating a member' do
    subject { post '/members', params: params.to_json, headers: headers }

    context 'with valid params' do
      let(:params) do
        {
          data: {
            type: 'members',
            attributes: {
              'first-name' => 'Sandi',
              'last-name' => 'Metz',
              'url' => 'http://www.example.com'
            }
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
      expect(body['data']).to be_an_instance_of(Array)
    end
  end

  describe 'viewing a member' do
    before do
      Member.create!(first_name: 'foo', last_name: 'bar', url: 'https://en.wikipedia.org/wiki/Foobar')
    end
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