require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:note) { build(:note, :with_preview) }

  context 'should' do
    it 'have title' do
      note.title = nil
      expect(note.valid?).to be false
      expect(note.errors[:title]).not_to be_empty
    end

    it 'have desc' do
      note.desc = nil
      expect(note.valid?).to be false
      expect(note.errors[:desc]).not_to be_empty
    end
  end
end
