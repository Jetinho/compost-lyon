class AddMetropoleFundingToSites < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :metropole_funding, :boolean
  end
end
