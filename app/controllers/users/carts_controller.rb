class Users::CartsController < ApplicationController
  def index
    @product_colors = {}
    @order = {}
    status = Order.statuses
    product_colors = ProductColor.by_ids(session[:order].keys).includes :product, :color if session[:order]
    if session[:order]
      product_colors.each do |product_color|
        @product_colors["#{product_color.id}"] = product_color
      end
    end
    @order = {
      order_pending: current_user.orders.by_status(status[:pending]),
      order_checked: current_user.orders.by_status(status[:checked]),
      order_shiped: current_user.orders.by_status(status[:shipped])
    } if current_user
  end
end
