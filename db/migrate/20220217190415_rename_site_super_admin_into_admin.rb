class RenameSiteSuperAdminIntoAdmin < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :super_admin, :admin
  end
end
