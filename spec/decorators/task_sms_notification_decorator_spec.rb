require 'rails_helper'

RSpec.describe TaskSmsNotificationDecorator do
  describe '#notify' do
    let(:task) { create(:task) }

    let(:sms_client) { instance_double(FakeSmsClient, send_sms: nil) }

    before do
      expect(FakeSmsClient).to receive(:new).with(
        account_id: ENV.fetch('FAKE_SMS_ACCOUNT_ID'),
        auth_token: ENV.fetch('FAKE_SMS_AUTH_TOKEN')
      ).and_return(sms_client)
    end

    let(:expected_sms_client_send_sms_args) do
      {
        from: ENV.fetch('FAKE_SMS_PHONE_NUMBER'),
        to: task.user.phone_number,
        body: "Task \"#{task.name}\" completed!"
      }
    end

    it 'calls send_sms' do
      described_class.notify(task:)

      expect(sms_client).to have_received(:send_sms).with(expected_sms_client_send_sms_args)
    end
  end
end
