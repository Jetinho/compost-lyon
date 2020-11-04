class AddDescriptionToOrganisations < ActiveRecord::Migration[6.0]
  def up
    add_column :organisations, :description, :text
    add_column :organisations, :meta_description, :string
    eisenia = Organisation.find_by(slug: :eisenia)
    eisenia.update(description: "Installation et maintenance de lombricomposteurs collectifs à Lyon métropole, sensibilisation et éducation à l'écologie")
    grand_lyon_metropole = Organisation.find_by(slug: :grand_lyon_metropole)
    grand_lyon_metropole.update(
      description: "Pour développer la pratique du compostage et réduire la quantité de déchets dans les poubelles des habitants, la Métropole de Lyon accompagne le déploiement de composteurs partagés sur son territoire.",
      slug: "grand-lyon-metropole"
    )
  end

  def down
    remove_column :organisations, :description, :text
    remove_column :organisations, :meta_description, :string
    grand_lyon_metropole = Organisation.find_by(slug: 'grand-lyon-metropole')
    grand_lyon_metropole.update(slug: :grand_lyon_metropole)
  end
end
