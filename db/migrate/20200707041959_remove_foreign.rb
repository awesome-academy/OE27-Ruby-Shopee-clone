class RemoveForeign < ActiveRecord::Migration[5.2]
  def change
    remove_reference :order_items, :product, index: true, foreign_key: true
  end
end
