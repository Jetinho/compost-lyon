class AddSlugToOrganisation < ActiveRecord::Migration[6.0]
  def change
    add_column :organisations, :slug, :string
  end
end
