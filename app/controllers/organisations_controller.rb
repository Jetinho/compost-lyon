class OrganisationsController < ApplicationController
  skip_before_action :authenticate_user!#, only: [ :home ]
    add_breadcrumb "Accueil", :root_path

  def show
    @organisation = Organisation.friendly.find(params[:id])
    @sites = @organisation.sites.order(site_type: :desc)
    add_breadcrumb "Acteurs", :sites_path
    add_breadcrumb @organisation.name, :site_path
  end
end
