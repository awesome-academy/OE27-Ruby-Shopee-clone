module Users::ProductColorsHelper
  def load_avatar product_color_id
    product_color = ProductColor.by_id product_color_id
    product_color.first.product_avatar
  end

  def productname_product_color product_color_id
    ProductColor.by_id(product_color_id).first.product_name
  end

  def colorname_product_color product_color_id
    ProductColor.by_id(product_color_id).first.color_color
  end
end
