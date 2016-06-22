class Movie < ActiveRecord::Base
  scope :title_filter, ->(word) { where("UPPER(title) LIKE ?", "%#{word}%".upcase) }
  scope :director_filter, ->(word) { where("UPPER(director) LIKE ?", "%#{word}%".upcase) }
  
  has_many :reviews

  mount_uploader :image, ImageUploader

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :image,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  def review_average
    reviews.sum(:rating_out_of_ten) / reviews.size unless reviews.empty?
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end
end
