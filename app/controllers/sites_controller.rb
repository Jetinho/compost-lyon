class SitesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show index search]
  load_resource instance_name: :site, find_by: :slug, only: %i[show new edit create update],
                class: Site, param_method: :site_params
  authorize_resource instance_name: :site, find_by: :slug, only: %i[new edit create update], class: Site
  add_breadcrumb page_name(:home), :root_path
  add_breadcrumb page_name(:collective_composting), :collective_composting_path

  def show
    @sites_marker_data = SiteDecorator.decorate_collection([@site]).to_map_marker_json
    add_site_breadcrumbs
  end

  def new
    authorize! :create, @site
  end

  def edit
    add_site_breadcrumbs
  end

  def create
    if @site.save
      redirect_to @site.decorate.composting_site_path
    else
      render :new, alert: 'Erreur de création'
    end
    authorize! :create, @site
  end

  def update
    if @site.update(site_params)
      flash[:success] = successful_update_flash_message
      redirect_to @site.decorate.composting_site_path
    else
      render :edit, alert: @site.errors
    end
  end

  private

  def site_params
    return params.require(:site).permit(Site.superadmin_editable_params) if current_user.admin?

    params.require(:site).permit(Site.editable_params)
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
    Geocoder.search(address).select { |r| r.data['address']['country_code'] == 'fr' }
  end
end
