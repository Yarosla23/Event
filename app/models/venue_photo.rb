class VenuePhoto < ApplicationRecord
  belongs_to :venue
  
  mount_uploader :photo, PhotoUploader
  
  validates :media_type, inclusion: { in: %w[photo video] }
  validates :video_url, presence: true, if: -> { media_type == 'video' }
  validates :photo, presence: true, if: -> { media_type == 'photo' }
end 