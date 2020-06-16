class Image < ApplicationRecord
  belongs_to :product
  mount_uploader :image, ProductImageUploader,
                 reject_if: proc { |param| param[:image].blank? && param[:image_cache].blank? &&
                     param[:id].blank? }, allow_destroy: true
end
