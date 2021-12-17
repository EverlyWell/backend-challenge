describe MembersController, type: :controller do
  render_views

  let(:logged_in_member) { create(:member) }

  before do
    sign_in logged_in_member, scope: :member
  end

  describe 'GET #show' do
    let(:member) do
      create(
        :member,
        shortened_personal_website_url: 'http://chiq.me/wvww',
        headings: create_list(:heading, 3)
      )
    end

    let(:get_show) do
      get :show, params: {id: member.id}
    end

    it 'responds with HTTP 200 Ok' do
       expect(get_show).to have_http_status(:ok)
    end

    it { expect(get_show.body).to have_content(member.name) }

    it { expect(get_show.body).to have_content(member.personal_website_url) }

    it { expect(get_show.body).to have_content(member.email) }

    it 'displays the headings' do
      member.headings.each do |heading|
        expect(get_show.body).to have_content(heading.name)
      end
    end
  end

  describe 'GET #index' do
    let(:members) do
      create_list(:member, 3, shortened_personal_website_url: 'http://chiq.me/wvww')
    end

    let(:get_index) do
      get :index
    end

    it 'responds with HTTP 200 Ok' do
       expect(get_index).to have_http_status(:ok)
    end

    it 'displays the members information' do
      members.each do |member|
        expect(get_index.body).to have_content(member.name)

        expect(get_index.body).to have_content(member.shortened_personal_website_url)
      end
    end
  end
end
