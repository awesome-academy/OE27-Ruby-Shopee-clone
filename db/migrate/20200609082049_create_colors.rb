class CreateColors < ActiveRecord::Migration[5.2]
  def change
    create_table :colors do |t|
      t.text :type

      t.timestamps
    end
  end
end
