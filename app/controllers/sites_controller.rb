class SitesController < ApplicationController
  skip_before_action :authenticate_user!#, only: [ :home ]

  def show
    @site = Site.find(params[:id])
    # binding.pry
  end

  def search
    address = params[:q]
    site = Site.near(address).first
    results = Geocoder.search(address)
    # Error if no result
    redirect_to site_path(site, distance: site.distance)
  end
end
