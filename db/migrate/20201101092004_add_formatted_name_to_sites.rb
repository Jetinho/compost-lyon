class AddFormattedNameToSites < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :formatted_name, :string
  end
end
