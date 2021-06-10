class UrlProcessorJob < ApplicationJob
  queue_as :default

  def perform(member_id)
    member = Member.find member_id
    member.process_url
  end
end
