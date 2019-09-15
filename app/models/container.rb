class Container < ApplicationRecord
  belongs_to :note
  has_many :slides, inverse_of: :container, dependent: :destroy
  accepts_nested_attributes_for :slides, reject_if: :all_blank, allow_destroy: true

  before_create :init_position

  validates :types_mask, presence: true
  validates :content, presence: true, if: [Proc.new {|c| %w[text blockquote].include? c.types_mask } ]

  TYPES = %w[text blockquote image slideshow]


  def check_mask(type)
    self.types_mask == type
  end


  private

  def init_position
    sibling = self.note.containers.order(:position).last
    self.position = sibling ? (sibling.position + 1) : 1
  end
end
