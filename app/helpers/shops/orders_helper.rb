module Shops::OrdersHelper
  def get_status status
    I18n.t("shop.order.index.#{status}")
  end

  def get_color_status status
    badge_class = {
      pending: "light",
      checked: "info",
      shipping: "warning",
      shipped: "success",
      cancel: "danger"
    }
    "badge badge-#{badge_class[status.to_sym]}"
  end

  def select_status
    Order.statuses.map do |key, value|
      [I18n.t("shop.order.index.#{key}"), value]
    end
  end

  def total_money order
    order.inject(0) {|total, item| total += (item.price_product * item.quantity)}
  end

  def sub_total price, qty
    price * qty
  end

  def badge_class order_item, i
    order_item.quantity < detail(order_item, i).quantity ? "success" : "danger"
  end

  def detail order_item, i
    order_item.product_color
  end
end
