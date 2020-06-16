class ProductColor < ApplicationRecord
  belongs_to :product
  belongs_to :color

  validates :color_id, presence: true
  validates :quantity, presence: true, numericality: {only_integer: true}
end
