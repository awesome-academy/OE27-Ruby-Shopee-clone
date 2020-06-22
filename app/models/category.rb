class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :sub_categories, dependent: :destroy, class_name: Category.name, foreign_key: :parent_id
  belongs_to :parent, class_name: Category.name
  scope :top_level, ->{ where parent_id: 0}
end
