class Ship < ApplicationRecord
  has_many :orders, dependent: :destroy
end
