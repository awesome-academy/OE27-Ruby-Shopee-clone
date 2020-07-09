class Shops::ImportProductsController < ShopsController
  def import_products
    if params[:file].present?
      ImportProductsService.new(params, current_user).import_data
      @error.blank? ?
        flash[:success] = t("shop.product.create.import_success") : flash[:danger] = @error
    else
      flash[:danger] = t "shop.product.create.import_fail"
    end
    redirect_to shops_products_path
  end
end
