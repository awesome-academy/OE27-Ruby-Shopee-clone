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
  scope :by_product, ->(id){where(product_id: id) if id.present?}
  scope :by_color, ->(id){where(color_id: id) if id.present?}
  scope :select_color, ->(id){where(id: id) if id.present?}
  scope :by_ids, ->(id){where(id: id) if id.present?}
  scope :best_sell, -> {find_by_sql("select p.product_id, sum(od.quantity)as quantity from product_colors as p inner join order_items as od on p.id = od.product_color_id group by  p.product_id order by sum(od.quantity) desc")}
end
