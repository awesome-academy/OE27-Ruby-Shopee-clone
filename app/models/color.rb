class Color < ApplicationRecord
  has_many :product_colors, dependent: :destroy
  has_many :product, through: :product_colors, dependent: :destroy
end
