class Product < ApplicationRecord
  CREATE_PRODUCT_PARAMS = [
      :name, :brand_id, :category_id, :price, :description, :avatar,
      product_colors_attributes: [:product_id, :color_id, :quantity],
      images_attributes: [:image]
  ]

  has_many :reviews, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :product_colors, dependent: :destroy
  has_many :users, through: :reviews, dependent: :destroy
  has_many :orders, through: :order_items, dependent: :destroy
  has_many :colors, through: :product_colors, dependent: :destroy
  has_many :images, dependent: :destroy
  belongs_to :user
  belongs_to :category
  belongs_to :brand

  mount_uploader :avatar, ProductImageUploader,
                 reject_if: proc { |param| param[:avatar].blank? &&
                     param[:id].blank? }, allow_destroy: true

  accepts_nested_attributes_for :product_colors, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :images, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true, uniqueness: true, length: {maximum: Settings.shop.name_max_length}
  validates :brand_id, :category_id, :user_id, presence: true
  validates :price, presence: true, numericality: true
  validates :description, presence: true, length: {maximun: Settings.shop.description_max_length}
end
