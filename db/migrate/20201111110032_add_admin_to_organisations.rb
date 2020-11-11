class AddAdminToOrganisations < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :bio, :text
    user = User.create(email: 'lyoncompost@gmail.com', password: 'compost')
    add_reference :organisations, :user, null: false, default: user.id, foreign_key: true
  end

  def down
    User.destroy_all
    remove_column :organisations, :user_id
    remove_column :users, :firstname
    remove_column :users, :lastname
    remove_column :users, :bio
  end
end
