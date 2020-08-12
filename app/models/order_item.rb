class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product_color
  belongs_to :product

  validates :quantity, presence: true, numericality: {only_integer: true, greater_than: Settings.quantity_min}
  validates :price_product, presence: true, numericality: {numericality: true, greater_than: Settings.quantity_min}
  validate :validate_quantity

  delegate :product_avatar, :product_name, :color_color, to: :product_color

  enum status: {
    pending: 0,
    checked: 1,
    shipping: 2,
    shipped: 3,
    cancel: 4
  }.freeze


  scope :by_user_id, ->(color_id){eager_load(:product).where products: {user_id: color_id} if color_id.present?}

  scope :by_status, -> status {where status: status if status.present?}

  scope :order_status, -> {order status: :asc}

  scope :search_by_id, -> id {where id: id}

  after_save :update_quantity
  before_create :set_order_status

  def validate_quantity
    errors.add(:quantity, I18n.t("order.out_of_stock")) if quantity > product_color.quantity
  end

  private

  def update_quantity
    product_quantity = product_color.quantity - quantity
    product_color.update_attributes quantity: product_quantity
  end

  def set_order_status
    self.status = Order.statuses[:pending]
  end
end
