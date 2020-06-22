class Order < ApplicationRecord
  scope :by_status, -> status {where status: status if status.present?}

  belongs_to :user
  has_many :order_item, dependent: :destroy

  delegate :name, to: :user, prefix: true

  enum status: {pending: 0, checked: 1}
end
