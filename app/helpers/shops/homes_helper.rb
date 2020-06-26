module Shops::HomesHelper
  def revenue_chart
    month_default = (1..12).to_a.product([0]).to_h
    @order_month.each{|month, money| month_default[month] = money}
    column_chart month_default,
                 colors: [Settings.shop.color_b00, Settings.shop.color_666],
                 xtitle: t("shop.index.month"), ytitle: t("shop.index.money"),
                 title: t("shop.index.chart_title")
  end
end
