class Profile < ApplicationRecord
  belongs_to :user
  mount_uploader :avatar, AvatarUploader

  validates :first_name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }
end
