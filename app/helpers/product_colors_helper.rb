module ProductColorsHelper
  def quantity_available id
    ProductColor.product_quantity id
  end
end
