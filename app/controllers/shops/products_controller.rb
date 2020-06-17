class Shops::ProductsController < ShopsController
  before_action :check_login
  before_action :load_product, only: %i(edit update)

  def index
    @products = current_user.products
                   .select_product_field
                   .order_by_created_at
                   .eager_load :brand, :category
  end

  def new
    @product = Product.new
    @product.product_colors.build
  end

  def create
    @product = current_user.products.build product_params
    if @product.save
      flash[:success] = t "shop.product.create.create_success"
      redirect_to shops_root_path
    else
      flash[:danger] = t "shop.product.create.create_fail"
      render :new
    end
  end

  def edit; end

  def update
    if @product.update_attributes product_params
      flash[:success] = t "shop.product.update.update_success"
      redirect_to shops_products_path
    else
      flash[:danger] = t "shop.product.update.update_fail"
      render :edit
    end
  end

  private

  def load_product
    @product = Product.find_by slug: params[:slug]
    return if @product

    flash[:warning] = t "shop.product.not_exist_product"
    redirect_to shops_root_path
  end

  def product_params
    params.require(:product).permit Product::PRODUCT_PARAMS
  end
end
