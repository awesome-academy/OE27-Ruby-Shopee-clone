class Review < ApplicationRecord
  REVIEW_PARAMS = [:content, :product_id, :user_id].freeze

  belongs_to :user, dependent: :destroy
  belongs_to :product, dependent: :destroy

  delegate :name, to: :user, prefix: true
end
