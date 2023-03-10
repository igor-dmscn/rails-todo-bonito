require 'rails_helper'

RSpec.describe TaskWhatsappNotificationDecorator do
  describe '#notify' do
    let(:task) { create(:task) }

    let(:whatsapp_client) { instance_double(FakeWhatsappClient, send_message: nil) }

    before do
      expect(FakeWhatsappClient).to receive(:new).with(
          account_id: ENV.fetch('FAKE_WHATSAPP_ACCOUNT_ID'),
          auth_token: ENV.fetch('FAKE_WHATSAPP_AUTH_TOKEN')
        ).and_return(whatsapp_client)
    end

    let(:expected_whatsapp_client_send_message_args) do
      {
        from: "whatsapp:#{ENV.fetch('FAKE_WHATSAPP_PHONE_NUMBER')}",
        to: "whatsapp:#{task.user.phone_number}",
        body: "Task \"#{task.name}\" completed!"
      }
    end

    it 'calls send_message' do
      described_class.notify(task:)

      expect(whatsapp_client).to have_received(:send_message).with(expected_whatsapp_client_send_message_args)
    end
  end
end
