class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  delegate :name, :avatar, to: :product, prefix: true

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  before_save :finalize

  private
    def finalize
      self.price_product = product.price
      self.amount = quantity * self.price_product
    end
end
