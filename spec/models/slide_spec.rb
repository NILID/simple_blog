require 'rails_helper'

RSpec.describe Slide, type: :model do
  let(:slide) { build(:slide, :with_slide) }

  context 'should' do
    it 'have title' do
      slide.slide = nil
      expect(slide.valid?).to be false
      expect(slide.errors[:slide]).not_to be_empty
    end
  end
end
