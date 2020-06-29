class Users::ProductsController < ApplicationController
  before_action :load_category, only: :index

  def index
    @products = Product
      .by_category(@ids)
      .by_price(params[:prices])
      .by_brand(params[:brands])
      .by_color(params[:colors])
      .page(params[:page])
      .per(Settings.record_per_page)
  end

  def new; end

  def load_category
    category = Category.find_by(id: params[:category_id])
    @ids = category.sub_categories.select(:id).to_a
    @ids << params[:category_id]
  end
end
