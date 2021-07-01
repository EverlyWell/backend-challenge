describe Member, type: :model do
  describe 'factory' do
    subject { build(:member) }

    it { is_expected.to be_valid }
  end

  xdescribe 'associations' do
    
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:url) }
  end
end
