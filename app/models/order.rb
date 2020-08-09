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
  before_create :set_order_status

  scope :by_status, -> status {where status: status if status.present?}

  scope :order_status, -> {order status: :asc}

  scope :search_by_id, -> id {where id: id}

  def subtotal
    order_items.to_a.sum { |item| item.amount }
  end

  private

  def update_subtotal
    self.total_amount = subtotal
  end

  def set_order_status
    self.status = Order.statuses[:pending]
  end

  def sent_notification
    self.order_items.each do |order_item|
      ActionCable.server.broadcast "notification_channel:#{order_item.product.user_id}", message: "#{t "order.product"}#{order_item.product.name}#{t "order.waiting"}"
    end
  end

  def sent_mailer_order
    SendEmailJob.perform_now self.user
  end
end
