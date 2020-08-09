class Shops::OrderItemsController < ShopsController
  before_action :load_order, only: %i(show update)

  def show;  end

  def update
    status = @order_items.update status: params[:status].to_i
    respond_to do |format|
      format.js{render json: status}
    end
  end

  private

  def load_order
    @order_items = OrderItem.search_by_id(params[:id])
      .includes(order: [:user], product: [:product_colors, :colors])
      .first
    return if @order_items

    flash[:danger] = t "shop.order.detail.no_order"
    redirect_to shops_order_items_path
  end

  def sent_notification
    ActionCable.server.broadcast "notification_channel:#{@order_item.product.user_id}", message: "#{t "order.product"}#{@order_item.product.name}#{t "order.waiting"}"
  end
end
