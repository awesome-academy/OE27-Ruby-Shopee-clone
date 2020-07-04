class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  delegate :name, :phone, to: :user, prefix: true

  enum status: {
    pending: 0,
    checked: 1,
    shipping: 2,
    shipped: 3,
    cancel: 4,
    inprogress: 5
  }.freeze

  before_create :set_order_status
  before_save :update_subtotal

  scope :by_status, -> status {where status: status if status.present?}
  scope :search_by_id, -> id {where id: id}

   def update_subtotal
    order_items.map { |oi| oi.valid? ? (oi.quantity * oi.price_product) : 0 }.sum
  end

  private
    def set_order_status
      self.status = 5
    end

    def update_subtotal
      self.total_amount = total_amount
  end
end
