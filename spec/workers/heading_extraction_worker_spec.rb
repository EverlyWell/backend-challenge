# frozen_string_literal: true

require 'rails_helper'

describe Members::Website::HeadingExtractionWorker, type: :worker do
  describe '.perform' do
    let(:member) { create(:member) }

    it 'calls Heading extraction service' do
      expect(::Members::Website::HeadingExtractionService).to receive(:call).with(member)

      described_class.new.perform(member.id)
    end
  end
end
