class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process convert: 'png' # Конвертировать изображения в PNG (опционально)
  process tags: ['post_picture'] # Добавить теги для изображений

  version :standard do
    process resize_to_fill: [100, 150, :north] # Создать версию изображения стандартного размера
  end

  version :thumbnail do
    process resize_to_fit: [50, 50] # Создать миниатюру
  end
end
