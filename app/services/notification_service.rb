class NotificationService
  def self.send_notifications
    Habit.where("send_at <= ?", Time.current).find_each do |habit|
      habit.send_notification
      habit.update(status: 'BOT')  # Обновите статус привычки
    end
  end
end
