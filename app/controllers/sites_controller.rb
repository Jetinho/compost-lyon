class SitesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show, :index, :search ]
  load_resource find_by: :slug, only: [ :show, :edit, :update ]
  authorize_resource find_by: :slug, only: [ :edit, :update ]
  add_breadcrumb page_name(:home), :root_path

  def show
    add_site_breadcrumbs
  end

  def edit
    add_site_breadcrumbs
  end

  def update
    if @site.update(site_params)
      redirect_to site_path(@site)
    else
      render :edit, alert: @site.errors
    end
  end

  def index
    @sites = Site.public_sites.all
    add_breadcrumb "Composteurs collectifs", :sites_path
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

  def site_params
    params.require(:site).permit(Site.editable_params)
  end

  def add_site_breadcrumbs
    add_breadcrumb display_resource_name(:organisations), :organisations_path
    add_breadcrumb @site.organisation_name, organisation_path(@site.organisation)
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
