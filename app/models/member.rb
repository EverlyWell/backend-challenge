require 'open-uri'

class Member < ApplicationRecord
  validates :name, :url, presence: true
  validates :state, inclusion: ["initialized", "processing_url", "success", "error_processing_url"]

  has_many :headings, dependent: :delete_all
  has_many :friendships, dependent: :delete_all
  has_many :friends, through: :friendships, class_name: 'Member'

  after_create :update_state_to_processing
  after_commit :schedule_url_processor, on: :create

  attr_accessor :parent

  def can_follow?(member)
    self != member && !friends.include?(member)
  end

  def follow(friend)
    self.friendships << Friendship.new(member: self, friend: friend)
    self.increment! :friend_count
    friend.friendships << Friendship.new(member: friend, friend: self)
    friend.increment! :friend_count
  end

  def unfollow(friend)
    self.friendships.where(friend: friend).destroy_all
    self.decrement! :friend_count
    friend.friendships.where(friend: self).destroy_all
    friend.decrement! :friend_count
  end

  def non_followers
    Member
      .joins("CROSS JOIN members as friends")
      .joins("LEFT JOIN friendships ON members.id = friendships.member_id AND friendships.friend_id = friends.id")
      .where("friends.id = ? AND members.id <> ? AND friendships.id IS NULL", id, id)
  end

  def search_in_non_followers(search)
    non_followers.where("members.search_column @@ websearch_to_tsquery('english', ?)", search)
  end

  def schedule_url_processor
    UrlProcessorJob.perform_later id
  end

  def process_url
    shorten_url
    save_page_headings
    update_search_vector
    update(state: 'success')
  rescue Exception
    update(state: 'error_processing_url')
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

  def update_search_vector
    document = headings.map(&:text).join(" ")

    # Use a prepared statement to prevent a SQL Injection
    query = <<-SQL
      UPDATE members SET search_column = to_tsvector('english', $1) WHERE id = $2
    SQL

    ApplicationRecord.connection.exec_query(
      query,
      '-- UPDATE MEMBER SEARCH --',
      [[nil, document], [nil, id]],
      prepare: true
    )
  end

  private

  def update_state_to_processing
    update(state: 'processing_url')
  end

  def page_headings
    @doc ||= Nokogiri::HTML(HTTParty.get(url))
    @headings ||= @doc.css('h1, h2, h3').map { |heading| [heading.name, heading.text] }
  end

  def save_page_headings
    page_headings.each do |type, text|
      self.headings << Heading.new(heading_type: type, text: text)
    end
  end
end
