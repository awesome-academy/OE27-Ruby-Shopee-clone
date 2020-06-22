class Shops::OrdersController < ShopsController
  before_action :check_login

  def index
    @orders = Order.by_status(params[:status]).eager_load :user, :order_item
  end
end