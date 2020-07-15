class ProductColor < ApplicationRecord
  belongs_to :product
  belongs_to :color
  has_many :order_items

  delegate :color, to: :color, prefix: true
  delegate :avatar, to: :product, prefix: true
  delegate :name, to: :product, prefix: true

  validates :color_id, presence: true
  validates :quantity, presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: Settings.shop.price_min,
              less_than_or_equal_to: Settings.shop.price_max
            }
  scope :by_product_and_color, -> (product_id, color_id) {where("product_id = ? AND color_id =  ?", product_id, color_id) if product_id.present? && color_id.present?}
  scope :select_color, ->(id){where(id: id) if id.present?}
  scope :by_id, ->(id){where(id: id) if id.present?}
end
