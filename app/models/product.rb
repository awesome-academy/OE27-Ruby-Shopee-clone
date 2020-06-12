class Product < ApplicationRecord
  has_many :reviews
  has_many :order_items
  has_many :product_colors
  has_many :users, through: :reviews
  has_many :orders, through: :order_items
  has_many :colors, through: :product_colors
  belongs_to :user
  belongs_to :category
  belongs_to :brand
end
