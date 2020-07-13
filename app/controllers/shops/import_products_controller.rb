class Shops::ImportProductsController < ShopsController
  def import_products
    if params[:file].present?
      import_service = Shops::ImportProductsService.new params, current_user
      if import_service.import_data
        flash[:success] = t "shop.product.create.import_success"
      else
        flash[:danger] = import_service.error
      end
    else
      flash[:danger] = t "shop.product.create.import_fail"
    end
    redirect_to shops_products_path
  end
end
