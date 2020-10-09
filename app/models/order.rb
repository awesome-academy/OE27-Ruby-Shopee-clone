class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  accepts_nested_attributes_for :order_items

  delegate :name, :phone, to: :user, prefix: true

  enum status: {
    pending: 0,
    checked: 1,
    shipping: 2,
    shipped: 3,
    cancel: 4
  }.freeze

  before_save :update_subtotal

  scope :by_status, -> status {where status: status if status.present?}
  scope :order_status, -> {order status: :asc}
  scope :search_by_id, -> id {where id: id}

  ransacker :total_money do
    Arel.sql("(SELECT DISTINCT SUM(price_product * quantity) FROM order_items
      WHERE order_items.order_id = orders.id GROUP BY orders.id)")
  end

  # Có thể sử dụng với scope hoặc viết như bên trên
  # scope :total_money_gteq, (lambda do |total|
  #   having("SUM(price_product * quantity) >= #{total}")
  # end)
  #
  # scope :total_money_lteq, (lambda do |total|
  #   having("SUM(price_product * quantity) <= #{total}")
  # end)
  #
  # def self.ransackable_scopes auth_object = nil
  #   %i(total_money_gteq total_money_lteq)
  # end

  def subtotal
    order_items.to_a.sum {|item| item.amount}
  end

  private

  def update_subtotal
    self.total_amount = subtotal
  end
end
