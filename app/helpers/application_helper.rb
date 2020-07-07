module ApplicationHelper
  def full_title page_title
    base_title = I18n.t "home.title"
    page_title.blank? ? base_title : page_title + " | " + base_title
  end

  def format_date date
    date.to_time.strftime I18n.t "datetime.formats.default"
  end

  def format_currency number
    number = locale == :en ? number.to_f / Settings.shop.dollar : number
    number_to_currency(number, unit: t("number.currency.format.unit"), separator: ",", delimiter: ".")
  end
   def custom_bootstrap_flash
    options = {
      success: "notice",
      error: "alert"
    }
    flash_messages = []
    flash.each do |type, message|
      options.each do |option, key|
        type = key.to_s if type == option
      end
      text = "<script>toastr.#{type}('#{message}');</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end
end
