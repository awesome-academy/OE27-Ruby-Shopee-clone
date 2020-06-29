module Users::ProductsHelper
  def load_color
    Color.select(:id, :color)
  end

  def load_brand
    Brand.select(:id, :name)
  end

  def load_product_newest
    Product.order_by_created_at.limit(Settings.record_per_page)
  end
end
