describe Heading, type: :model do
  describe 'factory' do
    subject { build(:heading) }

    it { is_expected.to be_valid }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:member) }
  end
end
