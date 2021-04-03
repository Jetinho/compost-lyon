require 'open-uri'

class GrandLyonSitesUpdater

  DATA_URL = "https://download.data.grandlyon.com/ws/grandlyon/gip_proprete.gipcomposteur_latest/all.json?maxfeatures=-1&start=1"
  # Response format (JSON to hash) :
  #  {"fields"=>["nom", "typesite", "adresse", "infoloc", "mail", "commune", "insee", "dateinstal", "gid"],
 # "values"=>

 # INSEE data has duplicate
 # gid had some changes between first csv data and current data...
 # JSON.load Site.find_by(gid: 4).data.to_h
 # Résidence le Grillon
 # sites_data.select{|s| s["gid"] == 4}
 # Les Sources
  def initialize
    @update_time = Time.now
  end


  def update_grand_lyon_composting_sites
    sites_data = fetch_sites_data
    update_sites(sites_data)
  end

  def add_new_grand_lyon_composting_sites
    # code
  end

  private

  # Will update existing data to use JSON
  def fetch_sites_data
    response = open(DATA_URL).read
    JSON.load(response)["values"]
  end

  def update_sites(sites_data)
    sites_data.each do |site_data|
      slug = 'composteur-' + site_data["nom"].parameterize
      site = Site.find_by_slug slug
      update_site(site, site_data) if site
    end
  end

  def update_site(site, site_data)
    site.update(
      gid: site_data["gid"],
      json_api_data: site_data.to_json,
      api_updated_at: @update_time,
    )
  end
end
