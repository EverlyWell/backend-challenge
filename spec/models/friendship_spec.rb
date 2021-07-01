describe Friendship, type: :model do
  describe 'factory' do
    subject { build(:friendship) }

    it { is_expected.to be_valid }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:member) }
    it { is_expected.to belong_to(:friend) }
  end
end
