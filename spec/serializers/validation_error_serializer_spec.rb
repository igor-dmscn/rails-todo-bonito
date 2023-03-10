require 'rails_helper'

RSpec.describe ValidationErrorSerializer do
  describe '#as_json' do
    let(:task) { build(:task, name: nil) }
    let(:expected_json) do
      {
      'error' => {
        'message' => 'Validation error',
        'details' => task.errors.full_messages
      }
    }
    end
    it 'serializes task errors' do
      expect(described_class.new(task.errors.full_messages).as_json).to eq(expected_json)
    end
  end
end
