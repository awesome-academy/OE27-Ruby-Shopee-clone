class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :sub_categories, dependent: :destroy, class_name: Category.name, foreign_key: :parent_id
  belongs_to :parent, class_name: Category.name
  scope :top_level, ->{includes(:sub_categories).where parent_id: Settings.parent_category}

  def load_ids category, ids
    ids = %W{#{category.id}}
    category.sub_categories.map do |sub|
      ids << load_ids(sub, ids)
    end
    ids
  end
end
