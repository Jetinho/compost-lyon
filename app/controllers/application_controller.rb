class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  add_flash_types :success


  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  def hide_breadcrumbs
    @hide_breadcrumbs = true
  end
end
