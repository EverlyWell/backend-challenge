require 'rails_helper'

describe 'Members', type: :request do
  let(:body) { JSON.parse(response.body) }
  let(:headers) { { "Accept" => "application/json", 'Content-Type' => 'application/json' } }

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
      let(:member) { Member.create(name: 'Leigh Halliday', url: 'https://pganalyze.com/blog/full-text-search-ruby-rails-postgres') }
      subject { get "/members/#{member.id}", headers: headers }

      before do
        stub_request(:post, "https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=firebase_key")
          .to_return({
            body: {
              "shortLink": "https://backendchallenge.page.link/3hNAQkhbKcxKfFYH8"
            }.to_json
          })

        stub_request(:get, "https://pganalyze.com/blog/full-text-search-ruby-rails-postgres")
          .to_return({
            body: File.new('spec/models/full-text-search-ruby-rails-postgres')
          })
      end

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
