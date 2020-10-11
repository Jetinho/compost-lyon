class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    eisenia = Organisation.first
    @sites = eisenia.sites.public_sites.to_json
  end
end
