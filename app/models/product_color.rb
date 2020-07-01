class ProductColor < ApplicationRecord
  belongs_to :product
  belongs_to :color

  delegate :color, to: :color, prefix: true

  validates :color_id, presence: true
  validates :quantity, presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: Settings.shop.price_min,
              less_than_or_equal_to: Settings.shop.price_max
            }
end
