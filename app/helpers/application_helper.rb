include Pagy::Frontend

module ApplicationHelper
  def lazy_image_tag(img)
    image_tag(img, class: 'img-responsive b-lazy', data: { src: img, src_small: img })
  end
end
