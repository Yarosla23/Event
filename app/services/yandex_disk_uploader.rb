require 'net/http'
require 'uri'
require 'json'
require 'fileutils'

class YandexDiskUploader
  API_URL = 'https://cloud-api.yandex.net/v1/disk/resources/upload'

  def initialize(oauth_token)
    @oauth_token = oauth_token
  end

  def upload(local_path, remote_path)
    raise "Файл не существует: #{local_path}" unless File.exist?(local_path)

    uri = URI(API_URL)
    uri.query = URI.encode_www_form(path: remote_path, overwrite: true)
    response = send_request(uri)

    href = JSON.parse(response.body)['href']
    raise "Ошибка получения ссылки для загрузки" unless href

    upload_file(local_path, href)
  end

  private

  def send_request(uri)
    puts "Sending request to: #{uri}"
    puts "OAuth token: #{@oauth_token}"

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Get.new(uri)
      req['Authorization'] = "OAuth #{@oauth_token}"
      http.request(req)
    end

    unless response.is_a?(Net::HTTPSuccess)
      body = response.body.force_encoding("UTF-8")
      raise "Ошибка при получении ссылки для загрузки: #{body}"
    end

    response
  end

  def upload_file(local_path, href)
    file = File.open(local_path, 'rb')

    upload_uri = URI(href)
    response = Net::HTTP.start(upload_uri.host, upload_uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Put.new(upload_uri)
      req.body = file.read
      http.request(req)
    end

    unless response.is_a?(Net::HTTPSuccess)
      raise "Ошибка при загрузке файла: #{response.body}"
    end
  ensure
    file.close if file
  end
end
