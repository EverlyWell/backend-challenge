require 'open-uri'

class Member < ApplicationRecord
  validates :name, :url, presence: true
  validates :state, inclusion: ["initialized", "processing_url", "success", "error_processing_url"]

  has_many :headings, dependent: :delete_all
  has_many :friendships, dependent: :delete_all
  has_many :friends, through: :friendships, class_name: 'Member'

  after_create :update_state_to_processing
  after_commit :schedule_url_procesor, on: :create

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

  def schedule_url_procesor
    UrlProcessorJob.perform_later id
  end

  def process_url
    shorten_url
    get_page_headings
    update(state: 'success')
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
    @doc ||= Nokogiri::HTML(HTTParty.get(url))
    @headings ||= @doc.css('h1, h2, h3').map { |heading| [heading.name, heading.text] }
  end

  def get_page_headings
    page_headings.each do |type, text|
      self.headings << Heading.new(heading_type: type, text: text)
    end
  end
end
