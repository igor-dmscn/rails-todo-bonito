require 'rails_helper'

RSpec.describe TaskEmailNotificationDecorator do
  describe '#notify' do
    let(:task) { create(:task) }

    let(:task_mailer) { instance_double(TaskMailer, task_completed_notification: double(deliver_now: nil)) }

    before do
      expect(TaskMailer).to receive(:with).with(task:).and_return(task_mailer)
    end

    it 'calls task_completed_notification' do
      described_class.notify(task:)

      expect(task_mailer).to have_received(:task_completed_notification)
    end
  end
end
