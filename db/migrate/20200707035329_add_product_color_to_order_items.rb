class AddProductColorToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :order_items, :product_color, foreign_key: true
  end
end
