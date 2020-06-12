class CreateBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :brands do |t|
      t.text :name
      t.text :phone
      t.string :slug
      t.timestamps
    end
  end
end
