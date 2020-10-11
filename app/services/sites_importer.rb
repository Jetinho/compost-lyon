class SitesImporter
  # CSV_HEADER = ["Nom Du Site", "Type_sites_compostage", "Modele_lombricomposteur", "Adresse", "Ville",
  # "Code_postal", 'Ouvert_au_public', "Conditions_usage", "Volume_valorise", "Nombre_Contributeurs",
  # "Nombre_repas_annuel", "Exploitant_structure", "Exploitant_contact", "Contact_responsable_site",
  # "Acteur_accompagnateur", "Fonctionnement_du_site", "Date_mise_en_route_du_site", "x","y"]
  def import
    csv_handler = CsvHandler.new
    csv_data = csv_handler.read('data/sites-eisenia-geocompost.csv')
    csv_data.each do |csv_line|
      site_data = map_site_data(csv_line)
      eisenia = Organisation.first
      site = eisenia.sites.build(site_data)
      site.save
    end
  rescue => e
    binding.pry
  end

  private

  def map_site_data(csv_line)
    {
      name: csv_line["Nom Du Site"],
      city: csv_line["Ville"],
      address: csv_line["Adresse"],
      zipcode: csv_line["Code_postal"],
      latitude: csv_line["x"].to_f,
      longitude: csv_line["y"].to_f,
      site_type: csv_line["Type_sites_compostage"],
      public: (csv_line["Ouvert_au_public"].downcase == 'oui' ? 1 : 0),
      participation_conditions: csv_line["Conditions_usage"],
      operation_conditions: csv_line["Fonctionnement_du_site"],
      contact_email: csv_line["Contact_responsable_site"],
      data: csv_line.to_json
    }
  end
end
