class TaskTelegramNotificationDecorator < TaskNotificationDecorator
  def initialize(task:)
    super(task:)
    
    telegram_client = FakeTelegramClient.new(auth_token: ENV.fetch('FAKE_TELEGRAM_AUTH_TOKEN'))
    telegram_client.send_message(
      chat_id: task.user.telegram_chat_id,
      text: "Task \"#{task.name}\" completed!"
    )
  end
end
