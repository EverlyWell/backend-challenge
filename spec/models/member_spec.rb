require 'rails_helper'

RSpec.describe Member, type: :model do
  describe 'generate_profile_metadata' do
    it 'saves heading html text to profile_metadata' do
      member = Member.create(first_name: 'Matt', last_name: 'Meyer', url: 'https://mmeyer.dev/')
      member.save
      expect(member.profile_metadata).to eq({"h1"=>["Matthew Meyer"], "h2"=>[], "h3"=>[" Greetings!", " Links"]})
    end
  end
end
