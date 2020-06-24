class Shops::HomesController < ShopsController
  def index
    order = current_user.products
                .eager_load(order_items: [:order])
    @order_month = order.group_by_month.total_money
    @earned = @order_month.values.reduce(0){|sum, i| sum + i}
    @total_products = order.this_month.total_product
    @total_orders = order.this_month.count
  end
end
