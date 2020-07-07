class Users::OrderItemsController < ApplicationController
  before_action :load_order, only: %i(create update destroy)
  before_action :store_target_location
  before_action :logged_in_user

  def create
    if session[:order].key? params[:order_item][:product_id]
      session[:order][params[:order_item][:product_id]]["quantity"] = params[:order_item][:quantity].to_i + session[:order][params[:order_item][:product_id]]["quantity"].to_i
    else
      session[:order][params[:order_item][:product_id]] = params[:order_item]
    end
    respond_to do |format|
      format.js { flash.now[:notice] =  t "order.susscess" }
    end

  end

  def update
  end

  def destroy
    session[:order].delete(params[:id])
    @id = params[:id]
    respond_to do |format|
      format.js { flash.now[:notice] =  t "order.delete" }
    end
  end

  private
  def load_order
    return if session[:order]

    session[:order] = Hash.new
  end
end
