class AddSlugDescriptionToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :slug, :string
    add_column :products, :description, :text
  end
end
