class Shops::ExportProductsController < ShopsController
  def export_products
    respond_to do |format|
      format.json do
        job_id = ExportProductsWorker.perform_async
        render json: {jid: job_id}
      end
    end
  end

  def export_status
    respond_to do |format|
      format.json do
        job_id = params[:job_id]
        job_status = Sidekiq::Status.get_all(job_id).symbolize_keys
        render json: {
          status: job_status[:status],
          percentage: job_status[:pct_complete]
        }
      end
    end
  end

  def export_download
    job_id = params[:id]
    exported_file_name = "product_export_#{job_id}.xlsx"
    filename = "Product_#{DateTime.now.strftime("%Y%m%d_%H%M%S")}"
    respond_to do |format|
      format.xlsx do
        send_file Rails.root.join("tmp", exported_file_name), type: :xlsx, filename: filename
      end
    end
  end
end
