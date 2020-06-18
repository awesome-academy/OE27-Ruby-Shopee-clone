class Image < ApplicationRecord
  belongs_to :product

  scope :by_product, -> (id, product_id) {where(id: id).where(product_id: product_id)}

  mount_uploader :image, ProductImageUploader,
                 reject_if: proc { |param| param[:image].blank? && param[:image_cache].blank? &&
                     param[:id].blank? }, allow_destroy: true
end
