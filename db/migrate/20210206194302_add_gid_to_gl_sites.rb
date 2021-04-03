class AddGidToGlSites < ActiveRecord::Migration[6.0]
  def up
    add_column :sites, :gid, :integer
  end

  def down
    remove_column :sites, :gid
  end
end
