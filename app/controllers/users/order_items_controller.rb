class Users::OrderItemsController < ApplicationController
  before_action :load_order, only: %i(create update destroy)

  def create
    product_color = params[:order_item][:product_color] if params[:order_item]
    if session[:order].key? product_color
      session[:order][product_color]["quantity"] = params[:order_item][:quantity].to_i + session[:order][product_color]["quantity"].to_i
    else
      session[:order][product_color] = params[:order_item]
    end
    respond_to :js
  end

  def update
    session[:order][params[:product_color]]["quantity"] = params[:quantity].to_i
  end

  def destroy
    session[:order].delete(params[:id])
    @id = params[:id]
    respond_to :js
  end

  private
  def load_order
    return if session[:order]

    session[:order] = Hash.new
  end
end
