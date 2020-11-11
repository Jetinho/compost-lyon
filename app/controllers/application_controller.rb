class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  add_flash_types :success

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  def hide_breadcrumbs
    @hide_breadcrumbs = true
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_back(fallback_location: root_path, alert: exception.message) }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end
end
