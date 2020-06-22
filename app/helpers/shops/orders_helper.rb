module Shops::OrdersHelper
  def check_status order
    order.pending? ? t("shop.order.index.pending") : t("shop.order.index.checked")
  end

  def select_status
    Order.statuses.to_a
  end
end
