module SessionsHelper
  def total_order session_order
    session_order.values.to_a.sum {|p| p["quantity"].to_i * p["price"].to_f} if session_order
  end

  def total_item quantity, price
    quantity.to_i * price.to_f
  end

  def count_orderitem
    session[:order].size if session[:order]
  end
end
