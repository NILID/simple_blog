class Note < ApplicationRecord
  acts_as_taggable

  belongs_to :user
  has_many :containers, inverse_of: :note

  has_attached_file :preview,
      styles: {
        thumb: {geometry: '400x300#'},
        large: {geometry: '1200>'}
      },
      path: ":rails_root/public/system/:attachment/:id/:style/:filename",
      url: "/system/:attachment/:id/:style/:filename"


  accepts_nested_attributes_for :containers, reject_if: :all_blank, allow_destroy: true

  validates :title, :desc, presence: true

  validates_attachment :preview, presence: true,
                                    size: { in: 0..20.megabytes },
                            content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }

  def to_param
    "#{id}-#{title.parameterize}"
  end
end