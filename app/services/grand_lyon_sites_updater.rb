require 'open-uri'

class GrandLyonSitesUpdater
  DATA_URL = "https://download.data.grandlyon.com/ws/grandlyon/gip_proprete.gipcomposteur_latest/all.json?maxfeatures=-1&start=1"
  # Response format (JSON to hash) :
  # {"fields"=>["nom", "typesite", "adresse", "infoloc", "mail", "commune", "insee", "dateinstal", "gid"],
  # "values"=>

  def initialize
    @update_time = Time.now
    @grand_lyon = Organisation.find_by_slug('grand-lyon-metropole')
    @existing_sites_gids = []
  end

  def update_grand_lyon_composting_sites
    sites_data = fetch_sites_data
    update_sites(sites_data)
    add_new_grand_lyon_composting_sites(sites_data)
  end

  private

  # Will update existing data to use JSON
  def fetch_sites_data
    uri = URI.parse DATA_URL
    response = uri.open.read
    JSON.parse(response)["values"]
  end

  def update_sites(sites_data)
    sites_data.each do |site_data|
      site = find_existing_site(site_data)
      next unless site

      @existing_sites_gids << site_data["gid"]
      next if site.gid

      update_site(site, site_data)
    end
  end

  def find_existing_site(site_data)
    find_site_by_gid(site_data) || find_site_by_slug(site_data)
  end

  def find_site_by_gid(site_data)
    gid = site_data["gid"]
    Site.find_by_gid gid
  end

  def find_site_by_slug(site_data)
    slug = SiteNameFormatter.format_slug(site_data["nom"])
    site = Site.find_by_slug slug
    return site if site

    prefixed_slug = "composteur-#{slug}"
    Site.find_by_slug prefixed_slug
  end

  def update_site(site, site_data)
    site.update(
      gid: site_data["gid"],
      json_api_data: site_data.to_json,
      api_updated_at: @update_time
    )
  end

  def add_new_grand_lyon_composting_sites(sites_data)
    new_sites_data = sites_data.reject { |site_data| @existing_sites_gids.include?(site_data['gid']) }
    new_sites_data.each { |site_data| add_new_site(site_data) }
  end

  def add_new_site(site_data)
    map_data = map_grand_lyon_metropole_site_data(site_data)
    site = @grand_lyon.sites.build(map_data)
    sleep 1 unless site.geocoded? # respect Nominatim quota https://github.com/alexreisner/geocoder/blob/master/README_API_GUIDE.md
    site.save
  rescue => e
    puts e
  end

  def map_grand_lyon_metropole_site_data(site_data)
    {
      gid: site_data["gid"],
      name: site_data["nom"],
      location_information: site_data["infoloc"],
      address: site_data["address"]["streetAddress"],
      zipcode: site_data["address"]["postalCode"],
      city: site_data["address"]["addressLocality"],
      site_type: site_data["typesite"],
      installation_date: site_data["dateinstal"].presence&.to_date,
      public: (site_data["typesite"].strip == 'Quartier'),
      contact_email: site_data["mail"],
      json_api_data: site_data.to_json,
      metropole_funding: true,
      api_updated_at: @update_time
    }
  end
end
