class Shops::ImportProductsController < ShopsController
  def import_products
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
    product_names = Product.pluck :name
    category_ids = Category.ids
    brand_ids = Brand.ids
    columns = %i(name slug category_id brand_id price description)
    data = []
    sheet.each_with_index do |row, i|
      next if i == 0
      _data = Hash[[columns, row].transpose]

      @error = case true
      when product_names.include?(_data.values[0])
        t("shop.product.create.name_exist", i: i + 1)
      when category_ids.exclude?(_data.values[2])
        t("shop.product.create.category_no_exist", i: i + 1)
      when brand_ids.exclude?(_data.values[3])
        t("shop.product.create.brand_not_exist", i: i + 1)
      when !_data.values[4].is_a?(Numeric)
        t("shop.product.create.price_numeric", i: i + 1)
      when _data.values.include?(nil)
        t("shop.product.create.error_row", i: i + 1)
      else nil
      end

      data << _data if @error.blank?
    end
    @error.blank? ? current_user.products.import(columns, data) : nil
  end

  def open_file file
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path)
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else @error = t "shop.product.create.file_error"
    end
  end
end
