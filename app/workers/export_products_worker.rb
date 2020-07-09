class ExportProductsWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  def perform
    products = current_user.products
      .select_fields
      .not_deleted
      .includes(:brand, :category, product_colors: [:color])

    total products.size
    xlsx_package = Axlsx::Package.new
    xlsx_workbook = xlsx_package.workbook
    xlsx_workbook.add_worksheet(name: "Users") do |worksheet|
      worksheet.add_row t(:shop)[:import][:header].values.unshift("#")
      products.each.with_index(1) do |product, i|
        worksheet.add_row product
        at i
        sleep 0.5
      end
    end
    xlsx_package.serialize Rails.root.join("tmp", "product_export_#{self.jid}.xlsx")
  end
end
