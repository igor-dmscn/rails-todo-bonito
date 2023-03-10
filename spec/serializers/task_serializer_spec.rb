require 'rails_helper'

RSpec.describe TaskSerializer do
  describe '#as_json' do
    let(:task) { create(:task) }
    let(:expected_json) do
      {
        'id' => task.id,
        'userId' => task.user_id,
        'status' => task.status,
        'name' => task.name,
        'createdAt' => task.created_at,
        'completedAt' => task.completed_at
      }
    end
    it 'serializes task' do
      expect(described_class.new(task).as_json).to eq(expected_json)
    end
  end
end
