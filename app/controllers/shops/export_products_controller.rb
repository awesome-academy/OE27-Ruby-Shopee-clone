class Shops::ExportProductsController < ShopsController
  def export_products
    job_id = ExportProductsWorker.perform_async current_user.id
    respond_to do |format|
      format.json do
        render json: {jid: job_id}
      end
    end
  end

  def export_status
    job_id = params[:job_id]
    status = Sidekiq::Status::status job_id
    percentage = Sidekiq::Status::pct_complete job_id
    respond_to do |format|
      format.json do
        render json: {
          status: status,
          percentage: percentage
        }
      end
    end
  end

  def export_download
    job_id = params[:id]
    exported_file_name = "product_export_#{job_id}.xlsx"
    respond_to do |format|
      format.xlsx do
        send_file Rails.root.join("public/downloads", exported_file_name), type: :xlsx
      end
    end
  end
end
