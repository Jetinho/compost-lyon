class OrganisationsController < ApplicationController
  load_and_authorize_resource find_by: :slug
  skip_before_action :authenticate_user!, only: [ :show, :index ]
  add_breadcrumb page_name(:home), :root_path

  def show
    @sites = @organisation.sites.order(site_type: :desc)
    @site_markers_data = SiteDecorator.decorate_collection(@sites).to_map_marker_json
    add_organisation_breadcrumbs
  end

  def new
    authorize! :create, @organisation
  end

  def create
     if @organisation.save
       redirect_to organisation_path(@organisation)
     else
       render :new, alert: 'Erreur de création'
     end
     authorize! :create, @organisation
  end

  def edit
    authorize! :edit, @organisation
    add_organisation_breadcrumbs
  end

  def update
    if @organisation.update(organisation_params)
      flash[:success] = successful_update_flash_message
      redirect_to organisation_path(@organisation)
    else
      redirect_back
    end
  end

  def index
    @organisations = Organisation.all
    add_breadcrumb page_name(:collective_composting), :collective_composting_path
    add_breadcrumb page_name(:organisations), :organisations_path
  end

  private

  def organisation_params
    current_user.super_admin? ? params.require(:organisation).permit(Organisation.superadmin_editable_params) :
                                params.require(:organisation).permit(Organisation.editable_params)
  end

  def add_organisation_breadcrumbs
    add_breadcrumb page_name(:collective_composting), :collective_composting_path
    add_breadcrumb page_name(:organisations), :organisations_path
    add_breadcrumb @organisation.name, :organisation_path
  end
end