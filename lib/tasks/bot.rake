namespace :telegram do
  desc "Запуск Telegram бота"
  task start: :environment do
    begin
      bot_service = BotService.new
      bot_service.start
      puts "Бот успешно запущен."
    rescue Telegram::Bot::Exceptions::ResponseError => e
      if e.message.include?("Forbidden: bot was blocked by the user")
        Rails.logger.warn("Пользователь заблокировал бота.")
        puts "Бот был заблокирован пользователем. Ошибка: #{e.message}"
      else
        Rails.logger.error("Ошибка при запуске бота: #{e.message}")
        puts "Ошибка при запуске бота: #{e.message}"
      end
    rescue StandardError => e
      Rails.logger.error("Произошла непредвиденная ошибка: #{e.message}")
      puts "Произошла непредвиденная ошибка: #{e.message}"
    end
  end

  desc "Остановка Telegram бота"
  task stop: :environment do
    $running = false
    puts "Запуск бота был остановлен."
  end
end
