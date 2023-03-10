require 'rails_helper'

RSpec.describe TaskTelegramNotificationDecorator do
  describe '#notify' do
    let(:task) { create(:task) }

    let(:telegram_client) { instance_double(FakeTelegramClient, send_message: nil) }

    before do
      expect(FakeTelegramClient).to receive(:new).with(
          auth_token: ENV.fetch('FAKE_TELEGRAM_AUTH_TOKEN')
        ).and_return(telegram_client)
    end

    let(:expected_telegram_client_send_message_args) do
      {
        chat_id: task.user.telegram_chat_id,
        text: "Task \"#{task.name}\" completed!"
      }
    end

    it 'calls send_message' do
      described_class.notify(task:)

      expect(telegram_client).to have_received(:send_message).with(expected_telegram_client_send_message_args)
    end
  end
end
