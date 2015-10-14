require 'securerandom'

class ShortenedURL < ActiveRecord::Base
  validates :long_url, presence: true
  validates :short_url, uniqueness: true, presence: true
  validates :submitter_id, presence: true
  #validates that the value at column "long url" is present

  has_many(
    :visits,
    class_name: "Visit",
    foreign_key: :shortened_url_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    through: :visits,
    source: :user
  )

  def self.random_code
    code = nil
    until !self.exists?(short_url: code) && code
      code = SecureRandom.urlsafe_base64(16)
    end
    code
  end

  def self.create_for_users_and_long_url!(user, long_url)
    ShortenedURL.create!(
      long_url: long_url,
      short_url: ShortenedURL.random_code,
      submitter_id: user.id
    )
  end
  # until valid?
  # self.short_url = ShortenedURL.random_code
  # end

  def num_clicks
    count = 0
    self.visits.each { |user| count += user.visits }
    count
  end

  def num_uniques
    self.visitors.count
  end

  #sets valid_visit = []
  def num_recent_uniques
    valid_visit = []
    self.visits.each do |visit|
      valid_visit << visit if visit.updated_at > 10.minutes.ago
    end
    valid_visit.count
  end




end
