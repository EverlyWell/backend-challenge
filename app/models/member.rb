# frozen_string_literal: true

class Member < ApplicationRecord
  validates :first_name, :last_name, presence: true
  validates :url, url: true # Via gem validate_url

  # I did not add an index to the `members.last_name` column. In a real
  # application you would have to consider adding an index to columns used like
  # this.
  scope :ordered, -> { order(last_name: :asc) }

  before_create :generate_short_url

  private

  def generate_short_url
    # Ideally we would use a Job queue to perform this task in a worker. We
    # should not make our web process wait for any external resource. To achieve
    # that we could use Sidekiq and then something like:
    #
    #   UrlShortenerWorker.perform_async(id)
    #
    # where id is the id of this Member record after creation.
    return unless url.present?

    self.short_url = UrlShortenerService.new.short_url_for(url)
  end
end
