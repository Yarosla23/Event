require 'net/dav'
class AvatarUploader < CarrierWave::Uploader::Base
  storage :file

  def store!

    super(model.avatar)
    local_path = file.path
    remote_path = "avatars/#{model.class.to_s.underscore}/#{model.id}/#{file.filename}"

    upload_to_yandex_disk(local_path, remote_path)

    model.avatar = "https://disk.yandex.ru/client/disk/#{remote_path}"

    File.delete(local_path) if File.exist?(local_path)
  end

  def store_dir
    "tmp/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  private

  def upload_to_yandex_disk(local_path, remote_path)
    dav = Net::DAV.new('https://webdav.yandex.ru', curl: false)
    dav.credentials(ENV['YANDEX_LOGIN'], ENV['YANDEX_APP_PASSWORD'])

    remote_path = remote_path.gsub('//', '/')

    parts = File.dirname(remote_path).split('/')
    path = ''
    parts.each do |part|
      path += "/#{part}"
      dav.mkdir(path) unless dav.exists?(path)
    end

    Rails.logger.info("Uploading to: /#{remote_path}")

    File.open(local_path, 'rb') do |file|
      dav.put(remote_path, file, file.size)
    end
  end
end
