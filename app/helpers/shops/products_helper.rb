module Shops::ProductsHelper
  def load_brand
    Brand.select(:id, :name)
  end

  def load_category
    Category.select(:id, :name)
  end

  def load_color
    Color.select(:id, :color)
  end
end
