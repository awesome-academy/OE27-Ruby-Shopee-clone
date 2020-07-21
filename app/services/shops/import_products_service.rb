class Shops::ImportProductsService
  attr_reader :error

  def initialize params, current_user
    @file = params[:file]
    @current_user = current_user
  end

  def import_data
    sheet = open_file
    return error if error.present?
    return self.error = I18n.t("shop.product.create.data_error") if sheet.last_row == 1
    columns = %i(name slug category_id brand_id price description)
    @data = []
    validate_data sheet, columns, @data
    self.error.blank? ? @current_user.products.import(columns, @data) : false
  end

  private

  def open_file
    case File.extname @file.original_filename
    when ".csv" then
      Roo::CSV.new @file.path
    when ".xls" then
      Roo::Excel.new @file.path
    when ".xlsx" then
      Roo::Excelx.new @file.path
    else
      @error = I18n.t("shop.product.create.file_error")
    end
  end

  def validate_data sheet, columns, data
    product_names = Product.pluck :name
    category_ids = Category.ids
    brand_ids = Brand.ids
    _error = []
    @error = []
    sheet.each_with_index do |row, i|
      next if i == 0
      _data = Hash[[columns, row].transpose]

      case true
      when product_names.include?(_data.values[0]) then _error << "name_exist"
      when category_ids.exclude?(_data.values[2]) then _error << "category_no_exist"
      when brand_ids.exclude?(_data.values[3]) then _error << "brand_not_exist"
      when !_data.values[4].is_a?(Numeric) then _error << "price_numeric"
      when _data.values.include?(nil) then _error << "error_row"
      else nil
      end
      if _error.blank?
        data << _data
      else
        _error.each {|e| @error << I18n.t("shop.product.create.#{e}", i: i + 1)}
        _error = []
      end
    end
  end
end
