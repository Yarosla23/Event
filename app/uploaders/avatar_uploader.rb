# class AvatarUploader < CarrierWave::Uploader::Base
#   storage :file

#   after :store, :upload_to_yandex

#   def store_dir
#     "tmp/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
#   end

#   private

#   def upload_to_yandex
#     binding.irb
#     file_path = model.avatar.path  # `avatar` — это атрибут модели, куда загружается файл

#     remote_path = "tmp/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
#     uploader = YandexDiskUploader.new(yandex_token)
#     uploader.upload(file_path, remote_path)
#     model.update_column(:avatar, remote_path)

#     # Удаляем файл после загрузки
#     File.delete(file_path) if File.exist?(file_path)
#   end

#   def yandex_token
#     "y0__xDEp7faARjj4TYgnPbY3xKR8ByG0QWZqXrapMBIWVc1-QXQcA"
#   end
# end
class AvatarUploader < CarrierWave::Uploader::Base
  storage :file  # Сохраняем файл локально перед загрузкой на Яндекс

  # Переопределим store! чтобы отправить файл на Яндекс
  def store!(file = nil)
    # Вызываем оригинальный store! для сохранения файла в локальной директории
    super(file)

    # Получаем путь к файлу
    local_path = file ? file.path : model.avatar.path  # используем путь, если файл передан

    # Загружаем на Яндекс
    uploader = YandexDiskUploader.new(user_token)
     remote_path = "tmp/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"

    uploader.upload(local_path, remote_path)

    # Сохраняем путь к файлу на Яндекс.Диске
    model.avatar = "https://disk.yandex.ru/client/disk#{remote_path}"
  end

  # Метод для определения каталога, в котором хранится файл локально
  def store_dir
    "tmp/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Токен пользователя для доступа к Яндекс.Диску
  def user_token
    "c2d56a039662413db1241850b089b857"
  end
end
