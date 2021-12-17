describe MembersSocialGraph do
  describe '#find_path_between_members' do
    # Build a social graph

    subject do
      described_class.new.find_path_between_members(from: member_1, to: member_2)
    end

    context 'with two members that are friends' do
      let(:member_1) { create(:member) }
      let(:member_2) { create(:member) }

      before do
        create(:friendship, member: member_1, friend: member_2)
      end

      it 'returns an array with their ids' do
        expect(subject).to eql [member_1, member_2]
      end
    end

    context 'with two members connected through a third friend' do
      let(:member_1) { create(:member) }
      let(:member_2) { create(:member) }
      let(:member_3) { create(:member) }

      before do
        create(:friendship, member: member_1, friend: member_3)
        create(:friendship, member: member_2, friend: member_3)
      end

      it 'returns an array with their ids' do
        expect(subject).to eql [member_1, member_3, member_2]
      end
    end

    context 'with two members unconnected members' do
      let(:member_1) { create(:member) }
      let(:member_2) { create(:member) }

      it 'return an empty array' do
        expect(subject).to eql []
      end
    end
  end
end
