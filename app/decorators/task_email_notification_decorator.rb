class TaskEmailNotificationDecorator < TaskNotificationDecorator
  def initialize(task:)
    super(task:)
    
    TaskMailer.with(task:).task_completed_notification.deliver_now
  end
end
