class AddProductToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :order_items, :products, index: true, foreign_key: true
  end
end
