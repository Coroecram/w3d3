class Visit < ActiveRecord::Base
  validates :visits, presence: true
  validates :shortened_url_id, presence: true
  validates :user_id, presence: true

  def self.record_visit!(user, shortened_url)
    shortened_id = (ShortenedURL.find_by(short_url: shortened_url))

    if shortened_id
      shortened_id = shortened_id.id
      if self.exists?(shortened_url_id: shortened_id)
        self.find_by(shortened_url_id: shortened_id).increment!(:visits)
      else
        self.create!(shortened_url_id: shortened_id,
        user_id: user.id
        )
      end
    end
  end

  belongs_to(
    :url,
    class_name: "ShortenedURL",
    foreign_key: :shortened_url_id,
    primary_key: :id
  )

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )
end
