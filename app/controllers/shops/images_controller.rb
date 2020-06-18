class Shops::ImagesController < ShopsController
  before_action :check_login

  def destroy
    image = Image.by_product(params[:id], params[:product_id]).first.destroy
    image_path = Rails.root.join(Settings.upload_product + image[:image])
    FileUtils.rm_f(image_path)
    @status = image.present? ? Settings.response_success : Settings.response_error
    respond_to do |format|
      format.json {
        render json: @status
      }
    end
  end
end
