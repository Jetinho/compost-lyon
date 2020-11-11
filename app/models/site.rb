class Site < ApplicationRecord
  extend FriendlyId
  belongs_to :organisation
  geocoded_by :full_address
  before_validation :set_formatted_name#, if: Proc.new { |site| site.name_changed? }
  friendly_id :formatted_name, use: :slugged
  after_validation :geocode, if: Proc.new { |site| !site.geocoded? || site.address_changed? || site.zipcode_changed? }
  scope :public_sites, -> { where(public: true) }
  scope :condominium, -> { where(site_type: "Pied d'immeuble") }

  delegate :admin, to: :organisation
  delegate :admin_id, to: :organisation

  EDITABLE_PARAMS = %i(name contact_email website_url location_information operation_conditions participation_conditions)

  def self.editable_params
    EDITABLE_PARAMS
  end

  def full_address
    [address, city, zipcode, 'France'].join(', ')
  end

  # To be added
  def photo
    # code
  end

  # Move to decorator
  def description
    preffix = "Composteur collectif #{format_site_type.downcase}"
    content = "\'#{formatted_name }\'."
    suffix = "Rejoignez-nous ou créez votre collectif pour composter à Lyon !"
    [preffix, content, suffix].join(' ')
  end

  def format_site_type
    site_type == "Prive" ? 'Privé' : "De #{site_type.downcase}"
  end

  def organisation_name
    organisation.name
  end

  def organisation_path
    organisations_path(organisation)
  end
  # To decorator

  private

  def set_formatted_name
    format_name = name.gsub(/compost?(\w)+/i, 'Composteur')
    format_name.prepend('Composteur ') unless format_name.split.first == 'Composteur'
    self.formatted_name = format_name
  end
end
