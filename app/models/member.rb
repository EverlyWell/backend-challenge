class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :name, :personal_website_url

  has_many :headings

  has_and_belongs_to_many :friends

  def pull_headings_async
    HeadingsPullerJob.perform_async(id)
  end

  def shorten_personal_website_url_async
    UrlShortnerJob.perform_async(id)
  end
end
