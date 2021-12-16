describe Member, type: :model do
  describe 'factory' do
    subject { build(:member) }

    it { is_expected.to be_valid }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:personal_website_url) }
  end
end

