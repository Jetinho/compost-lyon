class ModifyIpTypeInAddressSearches < ActiveRecord::Migration[6.1]
  def up
    change_table :address_searches do |t|
      t.change :ip, :bigint
    end
  end

  def down
    change_table :address_searches do |t|
      t.change :ip, :integer
    end
  end
end
