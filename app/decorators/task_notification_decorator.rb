class TaskNotificationDecorator
  attr_reader :task

  def initialize(task:)
    @task = task
  end

  def self.notify(**args)
    new(**args).notify
  end

  def user
    task&.user
  end

  def status
    task&.status
  end

  def name
    task&.name
  end
end
