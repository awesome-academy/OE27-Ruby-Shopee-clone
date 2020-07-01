class Shops::FilesController < ShopsController
  def export_file
    @products = current_user.products
      .select_fields
      .not_deleted
      .includes(:brand, :category, product_colors: [:color])
    respond_to do |format|
      format.xlsx {
        render template: 'shops/products/export'
      }
    end
  end

  def import_file
    if params[:file].present?
      import_data params[:file]
      @error.blank? ?
        flash[:success] = t("shop.product.create.import_success") : flash[:danger] = @error
    else
      flash[:danger] = t "shop.product.create.import_fail"
    end
    redirect_to shops_products_path
  end

  private

  def import_data file
    sheet = open_file file
    return @error if @error.present?
    return @error = t("shop.product.create.data_error") if sheet.last_row == 1
    columns = %i(name slug user_id category_id brand_id price description)
    data = []
    sheet.each_with_index do |row, i|
      next if i == 0
      _data = Hash[[columns, row].transpose]
      if _data.values.include? nil
        @error = t("shop.product.create.error_row", row: i + 1)
        return
      else
        data << _data
      end
    end
    @error.blank? ? Product.import(columns, data) : nil
  end

  def open_file file
    case File.extname(file.original_filename)
    when ".csv"
      Roo::CSV.new(file.path)
    when ".xls"
      Roo::Excel.new(file.path)
    when ".xlsx"
      Roo::Excelx.new(file.path)
    else
      @error = t "shop.product.create.file_error"
    end
  end
end
