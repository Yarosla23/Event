class MediaFile < ApplicationRecord
  belongs_to :attachable, polymorphic: true

  mount_uploader :file, MediaUploader

  validates :file, presence: true
  validates :file_type, presence: true
  validates :content_type, presence: true

  before_validation :set_file_attributes

  private

  def set_file_attributes
    if file.present?
      self.content_type = file.content_type
      self.file_size = file.size
      self.file_type = file.content_type.start_with?('video/') ? 'video' : 'image'
    end
  end
end 