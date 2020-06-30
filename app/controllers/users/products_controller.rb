class Users::ProductsController < ApplicationController
  def index
    @products = Product.by_price(params[:prices])
      .by_brand(params[:brands])
      .by_color(params[:colors])
      .page(params[:page])
      .per(Settings.record_per_page)
  end

  def new; end
end
