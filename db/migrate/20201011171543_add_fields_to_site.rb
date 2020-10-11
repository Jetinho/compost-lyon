class AddFieldsToSite < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :city, :string
    add_column :sites, :address, :string
    add_column :sites, :zipcode, :string
    add_column :sites, :type, :string
    add_column :sites, :public, :boolean
    add_column :sites, :participation_conditions, :text
    add_column :sites, :operation_conditions, :text
    add_column :sites, :contact_email, :string
    add_column :sites, :data, :text
    remove_column :sites, :organisation
  end
end
