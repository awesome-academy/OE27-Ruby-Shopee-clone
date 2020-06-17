module Shops::ProductsHelper
  def get_brand
    Brand.select(:id, :name)
  end

  def get_category
    Category.select(:id, :name)
  end

  def get_color
    Color.select(:id, :color)
  end
end
