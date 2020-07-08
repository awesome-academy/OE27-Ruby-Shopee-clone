class Shops::OrdersController < ShopsController
  before_action :check_login
  before_action :load_order, only: %i(show update)

  def index
    @search = Order.by_status(params[:status])
      .includes(:user, :order_items)
      .search(params[:q])
    @orders = @search.result
      .page(params[:page])
      .per(Settings.record_per_page)
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
    @order = Order.search_by_id(params[:id])
      .includes(:user, :order_items, products: [:product_colors, :colors])
      .first
    return if @order

    flash[:danger] = t "shop.order.detail.no_order"
    redirect_to shops_orders_path
  end
end
