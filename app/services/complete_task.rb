class CompleteTask < ApplicationService
  def initialize(task:)
    @task = task
  end
  
  def call
    task.update!(status: :completed, completed_at: Time.current)

    notify_user if task.user.notification_preferences['task_completed'].present?

    task
  end

  private

  attr_reader :task

  NOTIFICATION_DECORATORS = {
    'email' => TaskEmailNotificationDecorator,
    'sms' => TaskSmsNotificationDecorator,
    'telegram' => TaskTelegramNotificationDecorator,
    'whatsapp' => TaskWhatsappNotificationDecorator
  }.freeze

  private_constant :NOTIFICATION_DECORATORS

  def notify_user
    task.user.notification_preferences['task_completed'].each { |channel| NOTIFICATION_DECORATORS[channel].new(task:) }
  end
end
