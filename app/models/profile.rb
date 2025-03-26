class Profile < ApplicationRecord
  belongs_to :user
  has_many :reviews, as: :reviewable, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  validates :user_id, uniqueness: true, presence: true
  validates :gender, :is_active, presence: true

  validates :first_name, :last_name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :middle_name, allow_blank: true, length: { minimum: 2, maximum: 50 }
  validates :options, allow_blank: true, length: { minimum: 5, maximum: 300 }

  validates :birthday_date, presence: true
  validate :birthday_date_not_in_future

  def birthday_date_not_in_future
    if birthday_date.present? && birthday_date > Date.today
      errors.add(:birthday_date, "не может быть в будущем")
    end
  end
  
  validates :phone, presence: true, format: { 
    with: /\A(\+?\d{1,4}[\s\-]?)?(\(?\d{1,3}\)?[\s\-]?)?\d{1,4}[\s\-]?\d{1,4}[\s\-]?\d{1,4}\z/,
    message: "неверный формат телефона" 
  }, length: { is: 11, message: "должен содержать ровно 11 цифр" }, allow_blank: true

  def update_cover_color(new_color)
    if new_color.match?(/\A#[0-9a-fA-F]{6}\z/)
      update(cover_color: new_color)
    else
      errors.add(:cover_color, 'Недопустимый формат цвета')
      false
    end
  end

  def average_rating
    reviews.average(:rating)&.round(2) 
  end
end
