class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product_color
  belongs_to :product

  validates :quantity, presence: true, numericality: {only_integer: true, greater_than: Settings.quantity_min}
  validates :price_product, presence: true, numericality: {numericality: true, greater_than: Settings.quantity_min}
  validate :validate_quantity

  delegate :name, :avatar, to: :product, prefix: true

  after_save :update_quantity

  def validate_quantity
    errors.add(:quantity, I18n.t("order.out_of_stock")) if quantity > product_color.quantity
  end

  private
  def update_quantity
    product_quantity = product_color.quantity - quantity
    product_color.update_attributes quantity: product_quantity
  end
end
