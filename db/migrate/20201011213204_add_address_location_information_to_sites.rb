class AddAddressLocationInformationToSites < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :location_information, :string
  end
end
