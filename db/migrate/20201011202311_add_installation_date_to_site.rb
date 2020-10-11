class AddInstallationDateToSite < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :installation_date, :date
    add_column :sites, :website_url, :string
  end
end
