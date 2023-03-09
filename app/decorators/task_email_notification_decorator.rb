class TaskEmailNotificationDecorator < TaskNotificationDecorator
  def initialize(task:)
    super(task:)
  end
  
  def notify
    TaskMailer.with(task:).task_completed_notification.deliver_now
  end
end
