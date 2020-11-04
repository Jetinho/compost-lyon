class AddDescriptionToOrganisations < ActiveRecord::Migration[6.0]
  def change
    add_column :organisations, :description, :text
    add_column :organisations, :meta_description, :string
  end
end
