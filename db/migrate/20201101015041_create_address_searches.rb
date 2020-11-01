class CreateAddressSearches < ActiveRecord::Migration[6.0]
  def change
    create_table :address_searches do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.integer :ip
      t.float :closest_site_at

      t.timestamps
    end
  end
end
