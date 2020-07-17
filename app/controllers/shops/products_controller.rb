class Shops::ProductsController < ShopsController
  include Shops::ProductsConcern

  before_action :load_product, except: %i(index new create)

  def index
    @search = load_products params, current_user
    @limit = params[:q].present? ? params[:q][:per_page] : Settings.shop.default_per_page
    @products = @search.result.page(params[:page]).per @limit
    @brands = Brand.pluck :name
    @categories = Category.pluck :name
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

  def destroy
    if @product.destroy
      flash[:success] = t "shop.product.index.delete_success"
    else
      flash[:danger] = t "shop.product.index.delete_fail"
    end
    redirect_to shops_products_path
  end

  def restore
    if @product.restore
      flash[:success] = t "shop.product.index.restore_success"
    else
      flash[:danger] = t "shop.product.index.restore_fail"
    end
    redirect_to shops_products_path
  end

  private

  def load_product
    @product = Product.with_deleted.find_by slug: params[:slug]
    return if @product

    flash[:warning] = t "shop.product.not_exist_product"
    redirect_to shops_products_path
  end

  def product_params
    params.require(:product).permit Product::PRODUCT_PARAMS
  end
end
