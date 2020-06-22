module ApplicationHelper
  def full_title page_title
    base_title = I18n.t "home.title"
    page_title.blank? ? base_title : page_title + " | " + base_title
  end

  def format_date date
    date.to_time.strftime I18n.t "datetime.formats.default"
  end

  def format_currency number
    number = locale == :en ? number / Settings.shop.dollar : number
    number_to_currency(number, unit: t("number.currency.format.unit"), separator: ",", delimiter: ".")
  end

end
