# frozen_string_literal: true

module Members
  module Website
    class HeadingExtractionService
      extend LightService::Organizer

      class << self
        def call(member)
          with(member: member).reduce(actions)
        end

        private

        def actions
          [
            HeadingExtractionActions::GetWebsite,
            HeadingExtractionActions::ExtractHeadings,
            HeadingExtractionActions::PersistHeadings
          ]
        end
      end
    end
  end
end
