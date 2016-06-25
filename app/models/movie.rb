class Movie < ActiveRecord::Base
  has_many :reviews

  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true }
  validates :description, presence: true
  validates :release_date, presence: true
  validate :release_date_is_in_the_past

  validate :has_image?

  mount_uploader :uploaded_image, ImageUploader

  def review_average
    if reviews.empty?
      nil
    else
      reviews.sum(:rating_out_of_ten)/reviews.size
    end
  end

  def self.search(search_params)
    with_title(search_params[:title])
      .with_director(search_params[:director])
      .with_duration(search_params[:duration])
  end

  # Define scopes for search function
  scope :with_title, proc { |title|
    if title.present?
      where("lower(title) LIKE ?", "%#{title.downcase}%")
    end
  }

  scope :with_director, proc { |director|
    if director.present?
      where("lower(director) LIKE ?", "%#{director.downcase}%")
    end
  }

  scope :with_duration, proc { |duration|
    if duration == "1"     # under 90 minutes
      where("runtime_in_minutes < 90")
    elsif duration == "2"     # 90-120 minutes
      where(runtime_in_minutes: (90..120))
    elsif duration == "3"     # over 120 minutes
      where("runtime_in_minutes > 120")
    else
      # do nothing
    end
  }

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

  def has_image?
    unless uploaded_image.present? || poster_image_url.present?
      errors.add(:uploaded_image, "must have one of: poster image URL and/or uploaded image")
      errors.add(:poster_image_url, "must have one of: poster image URL and/or uploaded image")
    end
  end
end
