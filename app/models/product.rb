class Product < ApplicationRecord
  acts_as_paranoid
  PRODUCT_PARAMS = [
      :name, :brand_id, :category_id, :price, :description, :avatar,
      product_colors_attributes: [:id, :product_id, :color_id, :quantity, :_destroy],
      images_attributes: [:id, :image, :_destroy]
  ]

  has_many :product_colors
  has_many :colors, through: :product_colors
  has_many :images
  has_many :order_items, dependent: :destroy
  has_many :reviews
  belongs_to :user
  belongs_to :category
  belongs_to :brand

  accepts_nested_attributes_for :product_colors, allow_destroy: true, reject_if: :reject_product_colors && !:new_record?
  accepts_nested_attributes_for :images, allow_destroy: true, reject_if: :all_blank

  delegate :name, to: :brand, prefix: true
  delegate :name, to: :category, prefix: true
  delegate :name, to: :user, prefix: true

  validates :name, presence: true, uniqueness: true, length: {maximum: Settings.shop.name_max_length}
  validates :brand_id, :category_id, :user_id, presence: true
  validates :price, presence: true,
            numericality: {
              only_float: true,
              greater_than_or_equal_to: Settings.shop.price_min,
              less_than_or_equal_to: Settings.shop.price_max
            }
  validates :description, presence: true, length: {maximum: Settings.shop.description_max_length}

  before_save :set_slug

  scope :by_created_at_and_deleted_at, -> {order deleted_at: :asc, created_at: :desc}
  scope :select_fields, -> {select :id, :name, :slug, :price, :brand_id, :category_id, :created_at, :deleted_at}
  scope :by_slug, -> slug {where slug: slug}
  scope :search_product, -> value {
    if value.present?
      where("products.name LIKE '%#{value}%'")
        .or(where "products.description LIKE '%#{value}%'")
        .or(where "brands.name LIKE '%#{value}%'")
        .or(where "categories.name LIKE '%#{value}%'")
    end
  }
  scope :price_range, -> (price_min, price_max) {where "price BETWEEN ? AND ?", price_min, price_max if price_min.present? && price_max.present?}
  scope :group_by_month, -> {group("MONTH(orders.created_at)")}
  scope :total_money, -> {sum("order_items.price_product * order_items.quantity")}
  scope :total_product, -> {sum("order_items.quantity")}
  scope :total_order, -> {count("orders.id")}
  scope :this_month, -> {where "MONTH(orders.created_at) = ?", Time.now.strftime("%m")}
  scope :order_by_created_at, ->{order created_at: :desc}
  scope :select_product_field, ->{select :id, :name, :price, :brand_id, :category_id, :created_at}
  scope :by_brand, ->(brand){where brand_id: brand if brand.present?}
  scope :by_color, ->(color_id){includes(:product_colors).where product_colors: {color_id: color_id} if color_id.present?}
  scope :by_category, ->(id){where category_id: id}
  scope :by_id, ->(id){where(id: id)}
  scope :order_by_avg_star, -> {order avg_star: :desc}

  mount_uploader :avatar, ProductImageUploader,
                 reject_if: proc { |param| param[:avatar].blank? &&
                     param[:id].blank? }, allow_destroy: true

  def to_param
    slug
  end

  def reject_product_colors attributed
    attributed["quantity"].blank?
  end

  ransacker :created_at , type: :date do
    Arel.sql("products.created_at")
  end

  def total_quantity
    product_colors.to_a.sum {|p| p.quantity}
  end

  private

  def set_slug
    self.slug = name.to_s.parameterize
  end
end
