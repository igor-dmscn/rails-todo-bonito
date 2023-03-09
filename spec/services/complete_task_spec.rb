require 'rails_helper'

RSpec.describe CompleteTask do
  describe('#call') do
    let(:task) { create(:task) }
    subject { CompleteTask.call(task:) }
    
    it 'returns task with status completed' do
      expect(subject.status).to eq('completed')
    end

    context 'when user has email notification enabled' do
      let(:user) { create(:user, notification_preferences: { task_completed: %i[email] }) }
      let(:task) { create(:task, user:) }

      let(:task_email_notification_decorator) { instance_double(TaskEmailNotificationDecorator, notify: nil) }

      before do
        expect(TaskEmailNotificationDecorator).to receive(:new).with(task:).and_return(task_email_notification_decorator)
      end

      it 'sends email notification' do
        CompleteTask.call(task:)

        expect(task_email_notification_decorator).to have_received(:notify)
      end
    end

    context 'when user has sms notification enabled' do
      let(:user) { create(:user, notification_preferences: { task_completed: %i[sms] }) }
      let(:task) { create(:task, user:) }

      let(:task_sms_notification_decorator) { instance_double(TaskSmsNotificationDecorator, notify: nil) }

      before do
        expect(TaskSmsNotificationDecorator).to receive(:new).with(task:).and_return(task_sms_notification_decorator)
      end

      it 'sends sms notification' do
        CompleteTask.call(task:)

        expect(task_sms_notification_decorator).to have_received(:notify)
      end
    end

    context 'when user has telegram notification enabled' do
      let(:user) { create(:user, notification_preferences: { task_completed: %i[telegram] }) }
      let(:task) { create(:task, user:) }

      let(:task_telegram_notification_decorator) { instance_double(TaskTelegramNotificationDecorator, notify: nil) }

      before do
        expect(TaskTelegramNotificationDecorator).to receive(:new).with(task:).and_return(task_telegram_notification_decorator)
      end

      it 'sends telegram notification' do
        CompleteTask.call(task:)

        expect(task_telegram_notification_decorator).to have_received(:notify)
      end
    end

    context 'when user has whatsapp notification enabled' do
      let(:user) { create(:user, notification_preferences: { task_completed: %i[whatsapp] }) }
      let(:task) { create(:task, user:) }

      let(:task_whatsapp_notification_decorator) { instance_double(TaskWhatsappNotificationDecorator, notify: nil) }

      before do
        expect(TaskWhatsappNotificationDecorator).to receive(:new).with(task:).and_return(task_whatsapp_notification_decorator)
      end

      it 'sends whatsapp notification' do
        CompleteTask.call(task:)

        expect(task_whatsapp_notification_decorator).to have_received(:notify)
      end
    end
  end
end
