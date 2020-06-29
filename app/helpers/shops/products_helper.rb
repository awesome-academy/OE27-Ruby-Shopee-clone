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

  def show_message_validate obj, sub_title
    return unless obj.errors

    obj.errors[:name].map do |msg|
      "<div class='invalid-feedback d-block'>#{sub_title} #{msg}</div>"
    end.join().html_safe
  end

  def is_invalid obj
    obj.errors.any? && obj.errors[:name].present? ? "is-invalid" : ""
  end

  def load_price price, price_default = 0
    price.present? ? price : price_default
  end
end
