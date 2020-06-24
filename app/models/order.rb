class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  delegate :name, :phone, to: :user, prefix: true

  enum status: {pending: 0, checked: 1}.freeze

  scope :by_status, -> status {where status: status if status.present?}
  scope :search_by_id, -> id {where id: id}
end
