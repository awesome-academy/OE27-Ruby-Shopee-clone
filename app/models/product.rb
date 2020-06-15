class Product < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :product_colors, dependent: :destroy
  has_many :users, through: :reviews, dependent: :destroy
  has_many :orders, through: :order_items, dependent: :destroy
  has_many :colors, through: :product_colors, dependent: :destroy
  belongs_to :user
  belongs_to :category
  belongs_to :brand
end
