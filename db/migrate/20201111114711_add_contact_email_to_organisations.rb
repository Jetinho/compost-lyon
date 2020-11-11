class AddContactEmailToOrganisations < ActiveRecord::Migration[6.0]
  def up
    add_column :organisations, :contact_email, :string
    remove_column :organisations, :meta_description
  end
  def down
    add_column :organisations, :meta_description, :string
    remove_column :organisations, :contact_email
  end
end
