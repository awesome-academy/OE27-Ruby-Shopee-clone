class Users::ProductsController < ApplicationController
  before_action :load_category, only: :index

  def index
    @products = Product
      .by_category(@ids)
      .price_range(price_min, price_max)
      .by_brand(params[:brands])
      .by_color(params[:colors])
      .page(params[:page])
      .per(Settings.record_per_page)
  end

  def new; end

  def show
    @product = Product.find_by id: params[:id]
    @reviews = @product.reviews
    return if @product

    flash[:error] = t "product.fail_find_product"
    redirect_to root_url
  end

  private
  def load_category
    category = Category.find_by(id: params[:category_id])
    if category
      @ids = category.load_ids(category, @id).flatten!
    else
      flash[:error] = t "home.header.fail_find_cat"
      redirect_to root_url
    end
  end

  def price_max
    params[:price].split(";")[1] if params[:price]
  end

  def price_min
    params[:price].split(";")[0] if params[:price]
  end
end
