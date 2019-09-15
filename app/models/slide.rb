class Slide < ApplicationRecord
  belongs_to :container

  has_attached_file :slide,
        styles: {
           thumb: {geometry: '400x300#'},
           large: {geometry: '1200>'},
           bad: {geometry: '1200>'}
        },
        convert_options: {
          bad: "-quality 1 -strip"
        },
        path: ":rails_root/public/system/:attachment/:id/:style/:filename",
        url: "/system/:attachment/:id/:style/:filename"

  validates_attachment :slide, presence: true,
                               size: { in: 0..20.megabytes },
                               content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
end
