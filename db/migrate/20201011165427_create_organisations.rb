class CreateOrganisations < ActiveRecord::Migration[6.0]
  def change
    create_table :organisations do |t|
      t.string :name
      t.string :email
      t.string :website_url
      t.string :phone_number

      t.timestamps
    end
  end
end
