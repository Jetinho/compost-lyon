class SitesImporter
  # CSV_HEADER = ["Nom Du Site", "Type_sites_compostage", "Modele_lombricomposteur", "Adresse", "Ville",
  # "Code_postal", 'Ouvert_au_public', "Conditions_usage", "Volume_valorise", "Nombre_Contributeurs",
  # "Nombre_repas_annuel", "Exploitant_structure", "Exploitant_contact", "Contact_responsable_site",
  # "Acteur_accompagnateur", "Fonctionnement_du_site", "Date_mise_en_route_du_site", "x","y"]
  ORGANISATIONS = ["eisenia", "grand-lyon-metropole"]

  def import(slug)
    return 'organisation unknown' unless ORGANISATIONS.include? slug
    import_from(slug)
  rescue => e
    binding.pry
  end

  def import_from(slug)
    csv_data = send("data_#{slug}".to_sym)
    csv_data.each do |csv_line|
      site_data = map_site_data(slug, csv_line)
      organisation = Organisation.find_by_slug(slug)
      site = organisation.sites.build(site_data)
      sleep 1 unless site.geocoded? # respect Nominatim quota https://github.com/alexreisner/geocoder/blob/master/README_API_GUIDE.md
      site.save
      rescue => e
        binding.pry
    end
  end

  def data_grand_lyon_metropole
    csv_handler.read('data/sites-grand-lyon.csv')
  end

  def data_eisenia
    csv_handler.read('data/sites-eisenia-geocompost.csv')
  end

  private

  def csv_handler
    @csv_handler ||= CsvHandler.new
  end

  def map_site_data(slug, csv_line)
    send("map_#{slug}_site_data", csv_line)
  end

  def map_grand_lyon_metropole_site_data(csv_line)
    {
      name: csv_line["nom"],
      city: csv_line["commune"],
      address: csv_line["adresse"],
      location_information: csv_line["infoloc"],
      zipcode: csv_line["codpostal"],
      site_type: csv_line["typesite"],
      installation_date: csv_line["dateinstal"].to_date,
      public: (csv_line["typesite"] == 'Quartier'),
      website_url: csv_line["url"],
      contact_email: csv_line["mail"],
      data: csv_line.to_json
    }
  end

  def map_eisenia_site_data(csv_line)
    # Geocompost format
    {
      name: csv_line["Nom Du Site"],
      city: csv_line["Ville"],
      address: csv_line["Adresse"],
      zipcode: csv_line["Code_postal"],
      latitude: csv_line["x"].to_f,
      longitude: csv_line["y"].to_f,
      site_type: csv_line["Type_sites_compostage"],
      public: (csv_line["Ouvert_au_public"]&.downcase == 'oui'),
      participation_conditions: csv_line["Conditions_usage"],
      operation_conditions: csv_line["Fonctionnement_du_site"],
      contact_email: csv_line["Contact_responsable_site"],
      data: csv_line.to_json
    }
  end
end
