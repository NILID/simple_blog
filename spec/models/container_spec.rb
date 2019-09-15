require 'rails_helper'

RSpec.describe Container, type: :model do
  let(:container) { build(:container) }

  context 'should' do
    it 'have title' do
      container.types_mask = nil
      expect(container.valid?).to be false
      expect(container.errors[:types_mask]).not_to be_empty
    end
  end
end
