class Users::CartsController < ApplicationController
  def index
    @product_colors = {}
    status = Order.statuses
    product_colors = ProductColor.by_ids(session[:order].keys).includes :product, :color if session[:order]
    if session[:order]
      product_colors.each do |product_color|
        @product_colors["#{product_color.id}"] = product_color
      end
    end
    @order = current_user.orders if current_user
  end
end
