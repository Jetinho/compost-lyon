class CondominiumSitesController < ApplicationController
  skip_before_action :authenticate_user!#, only: [ :home ]
    add_breadcrumb "Accueil", :root_path

  def index
    @sites = Site.condominium.all
    add_breadcrumb "Composteurs de copropriété (\"Pied d'immeuble\")", :condominium_sites_path
  end
end
