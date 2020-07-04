class Users::OrderItemsController < ApplicationController
  before_save: load_order, only: %i(create update destroy)
  before_save: load_order_items, only: %i(update destroy)

  def create
    @order_item = @order.order_items.new(order_item_params)
    @order.save
    session[:order_id] = @order.id
  end

  def update
    @order_item.update_attributes(order_item_params)
    @order_items = @order.order_items
  end

  def destroy
    @order_item.destroy
    @order_items = @order.order_items
  end

  private
    def order_item_params
      params.require(:order_item).permit(:quantity, :product_id)
    end

    def load_order
      @order = current_order
    end

    def load_order_items
      @order_item = @order.order_items.find(params[:id])
    end
end
