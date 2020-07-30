class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  delegate :name, :avatar, to: :product, prefix: true

  before_save :cal_amount

  private
  def cal_amount
    self.amount = quantity * price_product
  end
end
