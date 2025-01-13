class Profile < ApplicationRecord
  belongs_to :user
  mount_uploader :avatar, AvatarUploader

  validates :user_id, uniqueness: true, presence: true
  validates :gender, :is_active, presence: true

  validates :first_name, :last_name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :middle_name, allow_blank: true, length: { minimum: 2, maximum: 50 }
  validates :options, allow_blank: true, length: { minimum: 5, maximum: 300 }

  def update_cover_color(new_color)
    if new_color.match?(/\A#[0-9a-fA-F]{6}\z/)
      update(cover_color: new_color)
    else
      errors.add(:cover_color, 'Недопустимый формат цвета')
      false
    end
  end
end
