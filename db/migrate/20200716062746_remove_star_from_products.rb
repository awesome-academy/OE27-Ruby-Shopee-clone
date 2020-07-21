class RemoveStarFromProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :count_rate
    remove_column :products, :total_star
    remove_column :products, :avgstar
  end
end
