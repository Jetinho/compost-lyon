class CondominiumSitesController < SitesController

  def index
    @sites = Site.condominium.all
    @site_markers_data = SiteDecorator.decorate_collection(@sites).to_map_marker_json
    add_breadcrumb page_name(:condominium_sites), :condominium_sites_path
  end

  private

  def add_site_breadcrumbs
    add_breadcrumb page_name(:condominium_sites), :condominium_sites_path
    add_breadcrumb @site.formatted_name, :site_path
  end
end
