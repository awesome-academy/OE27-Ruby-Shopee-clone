class CreateRating < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.integer :star
      t.references :product, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
