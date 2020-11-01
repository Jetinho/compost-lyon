class SitesController < ApplicationController
  skip_before_action :authenticate_user!#, only: [ :home ]

  def show
    @site = Site.find(params[:id])
  end

  def search
    address = params[:address]
    site = Site.public_sites.near(address).first
    results = Geocoder.search(address)
    if results.any?
      msg = "Voici le composteur le plus proche de l'adresse indiquée :"
      msg += "\r\n #{site.distance.round(1)} km de #{address}"
      flash[:success] = msg
      redirect_to site_path(site, distance: site.distance)
    else
      msg = "L'adresse indiquée n'a pas été reconnue. Essayez d'être plus précis"
      redirect_back(fallback_location: root_path, alert: msg)
    end
  end
end
