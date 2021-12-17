describe FriendshipsController, type: :controller do
  render_views

  let(:logged_in_member) { create(:member) }

  before do
    sign_in logged_in_member, scope: :member
  end

  describe 'POST #create' do
    let(:member) { create(:member) }
    let(:other_member) { create(:member) }

    let(:post_create) do
      post(
        :create,
        params: {
          friendship: {
            friend_id: member.id,
            member_id: other_member.id
          }
        }
      )
    end

    it 'responds with HTTP 200 Ok' do
       expect(post_create).to have_http_status(:redirect)
    end

    it 'creates a Friendship' do
      expect { post_create }.to change { Friendship.count }.by 1
    end

    it 'adds a friend to the member' do
      expect { post_create }.to change { member.reload.friends.count }.by 1
    end

    it 'adds a friend to the other member' do
      expect { post_create }.to change { other_member.reload.friends.count }.by 1
    end
  end
end
