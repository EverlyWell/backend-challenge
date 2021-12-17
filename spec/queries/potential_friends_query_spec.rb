describe PotentialFriendsQuery do
  describe '#get_potential_friends' do
    let!(:member) { create(:member) }
    let(:query) { 'Dog breeding' }

    subject { described_class.new(member, query).get_potential_friends }

    context 'there is a social connection with the member and others that match the query' do
      let!(:friend) { create(:member) }
      let!(:friend_of_friend) { create(:member) }

      before do
        create(:friendship, member: member, friend: friend)
        create(:friendship, member: friend, friend: friend_of_friend)
      end

      shared_examples 'successful search' do
        it 'returns the friend of a friend interested in dog breeding' do
          expect(subject).to eql [friend_of_friend]
        end

        it 'adds the path_to_other_member to the returned members' do
          returned_member = subject.first

          expect(returned_member.path_to_other_member).to be_present
          expect(returned_member.path_to_other_member).to eql [
            member,
            friend,
            friend_of_friend,
          ]
        end
      end

      context 'some members have headings that are a substring o the query' do
        before do
          create(:heading, name: 'Dog breeding in Ukraine', member: friend_of_friend)
        end

        include_examples 'successful search'
      end

      context 'some members have headings that are very similar to the query' do
        before do
          create(:heading, name: 'Dogs breeding', member: friend_of_friend)
        end

        include_examples 'successful search'
      end

      context 'some members have headings that are sound very to the query' do
        before do
          create(:heading, name: 'Dawgs breading', member: friend_of_friend)
        end

        include_examples 'successful search'
      end
    end

    context 'there is no social connection with the member and others' do
      it { expect(subject).to eql [] }
    end
  end
end
