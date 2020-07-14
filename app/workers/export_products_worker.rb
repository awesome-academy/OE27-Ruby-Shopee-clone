class ExportProductsWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  def perform user_id
    current_user = User.find_by id: user_id
    products = current_user.products
      .includes(:brand, :category, product_colors: [:color])
    total products.size
    xlsx_package = Axlsx::Package.new
    xlsx_package.use_autowidth = true
    wb = xlsx_package.workbook
    wb.styles do |s|
      col_widths= [8, 30, 20, 20, 15, 15, 12, 13, 18]
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
        total_money = 0
        i = 1
        add_row sheet, total_money, products, i
        sheet.add_row [I18n.t("shop.order.index.total_money"), "", "", "", "", "", "", "", total_money], style: title
        sheet.merge_cells "A#{i + 1}:H#{i + 1}"
        sheet.column_widths *col_widths
      end
    end
    xlsx_package.serialize Rails.root.join("public/downloads", "product_export_#{self.jid}.xlsx")
  end

  private

  def add_row sheet, total_money, products, i
    products.each.with_index(1) do |product, idx|
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
        sleep 0.02
      end
    end
  end
end
