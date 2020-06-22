class Shops::OrdersController < ShopsController
  before_action :check_login
  before_action :load_order, only: %i(show update)

  def index
    @orders = Order.by_status(params[:status]).eager_load :user, :order_items
  end

  def show; end

  def update
    status = @order.update status: params[:status].to_i
    respond_to do |format|
      format.js{render json: status}
    end
  end

  private

  def load_order
    @order = Order.search_by_id(params[:id]).includes(:user, :order_items, :products).first
    return if @order

    flash[:danger] = t "shop.order.detail.no_order"
    redirect_to shops_orders_path
  end
end
