class AddRefernceToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :order_items, :product_color, index: true
  end
end
