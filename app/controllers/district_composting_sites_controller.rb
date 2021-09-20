class DistrictCompostingSitesController < SitesController
  skip_before_action :authenticate_user!, only: [ :show, :index, :search ]

  def index
    @sites = Site.public_sites.all
    @site_markers_data = SiteDecorator.decorate_collection(@sites).to_map_marker_json
    add_breadcrumb page_name(:district_composting_sites), :sites_path
  end

  def search
    store_address_search
    if closest_site
      msg = "Voici le composteur le plus proche de l'adresse indiquée :"
      msg += "\r\n #{closest_site.distance.round(2)} km de #{address}"
      flash[:success] = msg
      redirect_to site_path(closest_site.slug)
    else
      msg = "L'adresse indiquée n'a pas été reconnue. Essayez d'être plus précis"
      redirect_back(fallback_location: root_path, alert: msg)
    end
  end

  private

  def add_site_breadcrumbs
    add_breadcrumb page_name(:district_composting_sites), :sites_path
    add_breadcrumb @site.organisation_name, collective_composting_organisation_path(@site.organisation)
    add_breadcrumb @site.formatted_name, :site_path
  end

  def store_address_search
    ip = IPAddr.new(request.remote_ip).to_i
    search = AddressSearch.find_or_initialize_by(name: address, ip: ip)
    if closest_site
      search.closest_site_at = closest_site.distance_to(address)
    end
    search.save
  end

  def address
    @address ||= params[:address]
  end

  def closest_site
    geocoding_results.any? && search_results&.first
  end

  def search_results
    @search_results ||= Site.public_sites.near(address)
  end

  def geocoding_results
    Geocoder.search(address).select{|r| r.data['address']['country_code'] == 'fr'}
  end
end
