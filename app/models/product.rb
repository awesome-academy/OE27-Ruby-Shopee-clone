class Product < ApplicationRecord
  PRODUCT_PARAMS = [
      :name, :brand_id, :category_id, :price, :description, :avatar,
      product_colors_attributes: [:id, :product_id, :color_id, :quantity],
      images_attributes: [:id, :image]
  ]

  before_save :set_slug

  scope :order_by_created_at, -> {order created_at: :desc}
  scope :select_product_field, -> {select :id, :name, :price, :brand_id, :category_id, :created_at}

  has_many :product_colors, dependent: :destroy
  has_many :colors, through: :product_colors, dependent: :destroy
  has_many :images, dependent: :destroy
  belongs_to :user
  belongs_to :category
  belongs_to :brand

  delegate :name, to: :brand, prefix: true
  delegate :name, to: :category, prefix: true

  mount_uploader :avatar, ProductImageUploader,
                 reject_if: proc { |param| param[:avatar].blank? &&
                     param[:id].blank? }, allow_destroy: true

  accepts_nested_attributes_for :product_colors, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :images, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true, uniqueness: true, length: {maximum: Settings.shop.name_max_length}
  validates :brand_id, :category_id, :user_id, presence: true
  validates :price, presence: true, numericality: true
  validates :description, presence: true, length: {maximum: Settings.shop.description_max_length}
  validates :description, presence: true, length: {maximum: Settings.shop.description_max_length}

  def to_param
    slug
  end

  private

  def set_slug
    self.slug = name.to_s.parameterize
  end
end
