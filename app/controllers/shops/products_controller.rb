class Shops::ProductsController < ShopsController
  before_action :check_login

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
    @product = current_user.products.build create_product_params
    if @product.save
      flash[:success] = t "shop.product.create.create_success"
      redirect_to shops_root_path
    else
      flash[:danger] = t "shop.product.create.create_fail"
      render :new
    end
  end

  private

  def create_product_params
    params.require(:product).permit Product::CREATE_PRODUCT_PARAMS
  end
end
