class MediaUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  # Добавляем поддержку видео
  def extension_allowlist
    %w(jpg jpeg gif png mp4 mov avi)
  end

  # Настройки для изображений
  version :thumb do
    process resize_to_fill: [200, 200]
  end

  version :medium do
    process resize_to_fill: [400, 400]
  end

  version :large do
    process resize_to_fill: [800, 800]
  end

  # Настройки для видео
  version :video_thumb do
    process :create_video_thumb
  end

  def create_video_thumb
    if file.content_type.start_with?('video/')
      manipulate! do |img|
        img.video_thumbnail
      end
    end
  end
end 