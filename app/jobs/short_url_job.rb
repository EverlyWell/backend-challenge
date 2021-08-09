class ShortUrlJob < ApplicationJob
  queue_as :member

  def perform(member_id)
    member = Member.find(member_id)
    member.shorten_url
    member.save
  end
end
