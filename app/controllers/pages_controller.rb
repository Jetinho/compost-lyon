class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :about ]

  def home
    @sites = Site.public_sites.to_json
  end

  def about
  end
end
