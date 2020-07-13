class Users::OrdersController < ApplicationController
  before_action :logged_in_user, only: %i(new create)

  def new; end

  def create
    @order = Order.new params_order[:order]
    if @order.save
      session.delete(:order)
    end
  end

  private
  def params_order
   order_params = Hash.new {|h, k| h[k] = Hash.new(&h.default_proc)}
   order_params[:order][:user_id] = session[:user_id]
   order_params[:order][:address] =  params[:address]
   order_params[:order][:phone] =  params[:phone]
   item = []
   session[:order].values.to_a.each do |order|
    item << {quantity: order["quantity"], product_color_id: order["product_color"], price_product: order["price"], amount: (order["quantity"].to_i * order["price"].to_i)}
   end
   order_params[:order][:order_items_attributes] = item
   order_params
  end
end
