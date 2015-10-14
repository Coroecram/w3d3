require 'securerandom'

class ShortenedURL < ActiveRecord::Base
  validates :long_url, presence: true
  validates :short_url, uniqueness: true, presence: true
  validates :submitter_id, presence: true
  #validates that the value at column "long url" is present

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


end
