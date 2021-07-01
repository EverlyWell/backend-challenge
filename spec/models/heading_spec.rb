describe Heading, type: :model do
  describe 'factory' do
    subject { build(:heading) }

    it { is_expected.to be_valid }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:member) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:content) }
  end
end
