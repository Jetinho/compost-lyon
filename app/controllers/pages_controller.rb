class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :about ]

  def home
    sites = SiteDecorator.decorate_collection(Site.public_sites)
    @site_markers_data = sites.to_map_marker_json
    hide_breadcrumbs
  end

  def about
  end
end
