class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :about ]

  def home
    sites = SiteDecorator.decorate_collection(Site.public_sites)
    @site_markers_data = sites.to_map_marker_json
    hide_breadcrumbs
  end

  def collective_composting
    sites = SiteDecorator.decorate_collection(Site.public_sites)
    @site_markers_data = sites.to_map_marker_json
    add_breadcrumb page_name(:home), :root_path
    add_breadcrumb page_name(:collective_composting), :collective_composting_path
  end

  def about
    add_breadcrumb page_name(:home), :root_path
    add_breadcrumb page_name(:about), :about_path
  end
end
