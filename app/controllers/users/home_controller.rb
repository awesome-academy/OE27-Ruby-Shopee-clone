class Users::HomeController < ApplicationController
  def index
    @product_top = Product.limit(Settings.top_star).order_by_avg_star
    product_ids = ProductColor.best_sell.pluck :product_id
    @product_best_sell = Product.limit(Settings.limit_product).by_id product_ids
  end
end
