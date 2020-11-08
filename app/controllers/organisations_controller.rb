class OrganisationsController < ApplicationController
  skip_before_action :authenticate_user!#, only: [ :home ]
    add_breadcrumb page_name(:home), :root_path

  def show
    @organisation = Organisation.friendly.find(params[:id])
    @sites = @organisation.sites.order(site_type: :desc)
    add_breadcrumb resource_name(:organisations), :organisations_path
    add_breadcrumb @organisation.name, :organisation_path
  end

  def index
    @organisations = Organisation.all
    add_breadcrumb resource_name(:organisations), :organisations_path
  end
end
