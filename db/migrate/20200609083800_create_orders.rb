class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.float :total_amount
      t.integer :status
      t.string :address
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
