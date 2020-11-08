class OrganisationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show, :index ]
  add_breadcrumb page_name(:home), :root_path

  def show
    @sites = organisation.sites.order(site_type: :desc)
    add_breadcrumb display_resource_name(:organisations), :organisations_path
    add_breadcrumb organisation.name, :organisation_path
  end

  def edit
    load_organisation
  end

  def update
    if organisation.update(organisation_params)
      flash[:success] = "Informations mises à jour"
      redirect_to organisation_path(organisation)
    else
      redirect_back
    end
  end

  def index
    @organisations = Organisation.all
    add_breadcrumb display_resource_name(:organisations), :organisations_path
  end

  private

  def load_organisation
    organisation
  end

  def organisation
    @organisation ||= Organisation.friendly.find(params[:id])
  end

  def organisation_params
    params.require(:organisation).permit(Organisation.editable_params)
  end
end
