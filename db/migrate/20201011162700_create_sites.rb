class CreateSites < ActiveRecord::Migration[6.0]
  def change
    create_table :sites do |t|
      t.string :name
      t.string :organisation
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
