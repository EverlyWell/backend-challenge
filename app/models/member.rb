class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :name, :personal_website_url

  has_many :headings

  has_many :friendships

  has_many :friendship_list, foreign_key: :member_id, class_name: 'Friendship'
  has_many :on_friendship_list, foreign_key: :friend_id, class_name: 'Friendship'

  def friends
    on_friendship_list.map(&:member) + friendship_list.map(&:friend)
  end

  def pull_headings_async
    HeadingsPullerJob.perform_async(id)
  end

  def shorten_personal_website_url_async
    UrlShortnerJob.perform_async(id)
  end
end
