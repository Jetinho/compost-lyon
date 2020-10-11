class RenameSiteType < ActiveRecord::Migration[6.0]
  def change
    rename_column :sites, :type, :site_type
  end
end
