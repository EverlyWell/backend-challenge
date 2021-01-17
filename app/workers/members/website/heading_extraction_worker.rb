# frozen_string_literal: true

module Members
  module Website
    class HeadingExtractionWorker
      include Sidekiq::Worker

      sidekiq_options queue: :members,
                      retry: 5

      def perform(member_id)
        if (member = ::Member.find(member_id))
          HeadingExtractionService.call(member)
        end
      end
    end
  end
end
