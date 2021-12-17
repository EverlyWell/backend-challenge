describe Friendship, type: :model do
  describe 'factory' do
    subject { create(:friendship) }

    it { is_expected.to be_valid }
  end

  describe 'validations' do
    subject { build(:friendship) }

    it 'expects to validate the ids are different' do
      member = create(:member)
      friendship_to_itself = build(:friendship, member: member, friend: member)

      error_message = 'A member cannot create a friend with itself'

      expect(friendship_to_itself).to be_invalid
      expect(friendship_to_itself.errors['friend'].last).to eql error_message 
    end

    it { should validate_uniqueness_of(:member_id).scoped_to(:friend_id) }
  end
end

