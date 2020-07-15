class Users::CartsController < ApplicationController
  def index
    @product_colors = ProductColor.where(id: session[:order].keys).includes :product, :color
    @index = 0
  end
end
