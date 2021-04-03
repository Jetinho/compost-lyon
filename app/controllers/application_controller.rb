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


  rescue_from Exception, :with => :internal_server_error unless Rails.env.development?
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found unless Rails.env.development?

  private

  def not_found(exception)
    ExceptionLogger.send(exception, params: params, referrer: request.referrer)
    render 'errors/not_found', status: 404
  end

  def internal_server_error(exception)
    ExceptionLogger.send(exception)
    render 'errors/internal_server_error', status: 500
  end

end
