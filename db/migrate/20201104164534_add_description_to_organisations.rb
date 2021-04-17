class AddDescriptionToOrganisations < ActiveRecord::Migration[6.0]
  def up
    add_column :organisations, :description, :text
    add_column :organisations, :meta_description, :string
  end

  def down
    remove_column :organisations, :description, :text
    remove_column :organisations, :meta_description, :string
  end
end
