require 'telegram/bot'

class TelegramService
  TOKEN = '7965719411:AAG4cVzYor_yj21nqoVZcSoZaPdrW4f0Kf0'

  def self.send_message(chat_id, text)
    begin
      bot = Telegram::Bot::Client.new(TOKEN)
      bot.api.send_message(chat_id: chat_id, text: text)
    rescue Telegram::Bot::Exceptions::ResponseError => e
      Rails.logger.error("Failed to send message to #{chat_id}: #{e.message}")
      if e.message.include?("Forbidden: bot was blocked by the user")
        Rails.logger.warn("User with chat_id #{chat_id} has blocked the bot.")
      else
        raise e
      end
    end
  end
  
  def self.register_user(chat_id, token)
    user = User.find_by(telegram_token: token)
    return if user.nil?

    if user.chat_id != chat_id
      user.update(chat_id: chat_id)
    end
  end
end
