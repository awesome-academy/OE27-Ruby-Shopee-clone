class Users::OrdersController < ApplicationController
  before_action :authenticate_user!

  def new; end

  def create
    @order = Order.new params_order[:order]
    if @order.save
      session.delete :order
      sent_notification @order
    end
    respond_to :js
    redirect_to carts_path
  end

  private

  def params_order
   order_params = Hash.new {|h, k| h[k] = Hash.new(&h.default_proc)}
   order_params[:order][:user_id] = current_user.id
   order_params[:order][:address] = params[:address]
   order_params[:order][:phone] = params[:phone]
   item = []
   session[:order].values.to_a.each do |order|
    item << {quantity: order["quantity"], product_color_id: load_product_id(order["product_color"]), product_id: load_product_id(order["product_color"]), price_product: order["price"], amount: (order["quantity"].to_i * order["price"].to_i)}
   end
   order_params[:order][:order_items_attributes] = item
   order_params
  end

  def load_product_id id
    ProductColor.by_ids(id).first.product_id
  end
end
