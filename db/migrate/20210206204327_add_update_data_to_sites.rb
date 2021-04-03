class AddUpdateDataToSites < ActiveRecord::Migration[6.0]
  def up
    add_column :sites, :json_api_data, :text
    add_column :sites, :api_updated_at, :datetime
  end
  def down
    remove_column :sites, :json_api_data
    remove_column :sites, :api_updated_at
  end
end
