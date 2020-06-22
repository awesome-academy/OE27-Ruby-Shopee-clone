module Shops::OrdersHelper
  def get_status order
    order.pending? ? t("shop.order.index.pending") : t("shop.order.index.checked")
  end

  def select_status
    Order.statuses.to_a
  end

  def total_money order
    order.inject(0){|total, item| total += (item.price_product * item.quantity)}
  end
end
