class RemoveProductsId < ActiveRecord::Migration[5.2]
  def change
    remove_column :order_items, :products_id
  end
end
