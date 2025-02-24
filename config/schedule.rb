every 1.minute do
  runner "BotService.new.start"
end

every 1.minute do
  runner "NotificationService.send_notifications"
end
