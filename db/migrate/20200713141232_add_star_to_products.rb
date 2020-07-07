class AddStarToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :avgstar, :float
  end
end
