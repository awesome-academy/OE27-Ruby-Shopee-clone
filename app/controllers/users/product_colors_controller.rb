class Users::ProductColorsController < ApplicationController
  def index
    result = {}
    result[:product_color] = ProductColor.by_product_and_color(params[:product_id], params[:color_id]).ids
    result[:quantity] = ProductColor.by_id(result[:product_color]).first.quantity
    respond_to do |format|
      format.html
      format.json { render json: result }
    end
  end
end
