class AddRoleAndDeletedAtToAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :role, :integer, default: 0
    add_column :admins, :deleted_at, :datetime, default: ""
  end
end
