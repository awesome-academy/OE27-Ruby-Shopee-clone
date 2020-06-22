class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  delegate :name, :avatar, to: :product, prefix: true
end
