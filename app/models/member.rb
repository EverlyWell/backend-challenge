class Member < ApplicationRecord
  validates :name, :url, presence: true
  validates :state, inclusion: ["initialized", "processing_url", "success", "error_processing_url"]

  has_many :headings, dependent: :delete_all
  has_many :friendships, dependent: :delete_all
  has_many :friends, through: :friendships, class_name: 'Member'

  after_create :update_state_to_processing
  after_commit :schedule_url_processor, on: :create

  scope :processed, -> { where(state: 'success').order(name: :asc) }

  attr_accessor :introduction_path

  def follow(friend)
    transaction do
      self.friendships.create! member: self, friend: friend
      self.increment! :friend_count
      friend.friendships.create! member: friend, friend: self
      friend.increment! :friend_count
    end
  rescue ActiveRecord::RecordInvalid
  end

  def unfollow(friend)
    # If the user clicks the "Unfollow" button fast enough, the
    # backend will get many requests that can cause a race condition
    # in which the friend count gets out of sync. Locking the member
    # prevents it.
    with_lock do
      ndeleted = Friendship
        .where(member: self, friend: friend)
        .or(Friendship.where(member: friend, friend: self))
        .delete_all

      raise StandardError.new if ndeleted.zero?

      self.decrement! :friend_count
      friend.decrement! :friend_count
    end
  rescue StandardError
  end

  def non_followers
    Member
      .joins("CROSS JOIN members as friends")
      .joins("LEFT JOIN friendships ON members.id = friendships.member_id AND friendships.friend_id = friends.id")
      .where("friends.id = ? AND members.id <> ? AND friendships.id IS NULL", id, id)
  end

  def search_in_non_followers(search)
    search_query(search)
      .group_by(&:id)
      .values.map(&:first)
  end

  def search_query(search)
    non_followers
      .joins("INNER JOIN headings ON members.id = headings.member_id")
      .where("headings.search_vector @@ websearch_to_tsquery('english', ?)", search)
      .select("members.*, headings.text as matching_heading")
  end

  def schedule_url_processor
    UrlProcessorJob.perform_later id
  end

  def process_url
    shorten_url
    save_page_headings
    update(state: 'success')
  rescue Exception => e
    update(state: 'error_processing_url')
    raise e
  end

  def shorten_url
    response = HTTParty.post("https://firebasedynamiclinks.googleapis.com/v1/shortLinks",
                  query: { key: Rails.application.secrets.firebase_key },
                  headers: { 'Content-Type' => 'application/json' },
                  body: {
                    dynamicLinkInfo: {
                      domainUriPrefix: "https://backendchallenge.page.link",
                      link: url 
                    }
                  }.to_json)
    self.shortened_url = JSON.parse(response.body)["shortLink"]
  end

  private

  def update_state_to_processing
    update(state: 'processing_url')
  end

  def page_headings
    response = HTTParty.get(url)
    @doc ||= Nokogiri::HTML(response.body)
    @headings ||= @doc.css('h1, h2, h3').map { |heading| [heading.name, heading.text] }
  end

  def save_page_headings
    self.headings = []
    page_headings.each do |type, text|
      self.headings << Heading.new(heading_type: type, text: text)
    end
  end
end
