class RenameLinkToImageInImages < ActiveRecord::Migration[5.2]
  def change
    rename_column :images, :link, :image
  end
end
