class AddDeletedAddToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :deleted_at, :datetime
  end
end
