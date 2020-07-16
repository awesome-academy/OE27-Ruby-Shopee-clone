class AddStarToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :count_rate, :integer
    add_column :products, :total_star, :integer
    add_column :products, :avg_star, :float
  end
end
