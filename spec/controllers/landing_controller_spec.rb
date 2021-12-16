describe LandingController, type: :controller do
  render_views

  describe 'GET #show' do
    let(:get_show) do
      get :show
    end

    it 'responds with HTTP 200 Ok' do
       expect(get_show).to have_http_status(:ok)
    end
  end
end
