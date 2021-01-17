# frozen_string_literal: true

module Members
  module Website
    class UrlShortenerWorker
      include Sidekiq::Worker

      sidekiq_options queue: :members,
                      retry: 5

      def perform(member_id)
        if (member = ::Member.find(member_id))
          UrlShortenerService.call(member)
        end
      end
    end
  end
end
