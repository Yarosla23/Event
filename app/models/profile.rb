class Profile < ApplicationRecord
  belongs_to :user
  mount_uploader :avatar, AvatarUploader

  validates :first_name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }

  def update_cover_color(new_color)
    if new_color.match?(/\A#[0-9a-fA-F]{6}\z/)
      update(cover_color: new_color)
    else
      errors.add(:cover_color, 'Недопустимый формат цвета')
      false
    end
  end
end
