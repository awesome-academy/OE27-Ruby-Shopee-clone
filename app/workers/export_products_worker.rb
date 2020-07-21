class ExportProductsWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  def perform product_ids
    products = Product.where(id: product_ids)
      .includes :brand, :category, product_colors: [:color]
    total products.size
    xlsx_package = Axlsx::Package.new
    xlsx_package.use_autowidth = true
    wb = xlsx_package.workbook
    wb.styles do |s|
      col_widths = [8, 30, 20, 20, 15, 15, 12, 13, 18]
      title = wb.styles.add_style(
        bg_color: "BBBBBB",
        fg_color: "111111",
        sz: 14,
        b: true,
        border: {style: :thin, color: "111111"},
        alignment: {horizontal: :center}
      )
      wb.add_worksheet(name: "Products") do |sheet|
        sheet.add_row I18n.t(:shop)[:import][:header].values.unshift("#"), style: title
        add_data sheet, products, title
        sheet.column_widths *col_widths
      end
    end
    xlsx_package.serialize Rails.root.join("public/downloads", "product_export_#{self.jid}.xlsx")
  end

  private

  def add_data sheet, products, title
    total_money = 0
    i = 1
    products.each_with_index do |product, idx|
      product.product_colors.each do |p|
        sheet.add_row [
                        i,
                        product.name,
                        product.brand_name,
                        product.category_name,
                        product.created_at,
                        p.color.color,
                        product.price,
                        p.quantity,
                        product.price * p.quantity
                      ]
        total_money += product.price * p.quantity
        i += 1
        at idx
        sleep 0.025
      end
    end
    sheet.add_row [I18n.t("shop.order.index.total_money"), "", "", "", "", "", "", "", total_money], style: title
    sheet.merge_cells "A#{i + 1}:H#{i + 1}"
  end
end
