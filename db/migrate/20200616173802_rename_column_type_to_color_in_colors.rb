class RenameColumnTypeToColorInColors < ActiveRecord::Migration[5.2]
  def change
    rename_column :colors, :type, :color
  end
end
