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
    if category
      @ids = category.load_ids(category, @id).flatten!
    else
      flash[:error] = t "home.header.fail_find_cat"
      redirect_to root_url
    end
  end
end
