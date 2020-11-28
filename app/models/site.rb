class Site < ApplicationRecord
  extend FriendlyId
  belongs_to :organisation, class_name: 'CollectiveComposting::Organisation'
  geocoded_by :full_address
  validates :name, presence: true
  validates :slug, presence: true

  friendly_id :formatted_name, use: :slugged
  before_validation :set_slug
  after_validation :set_formatted_name, if: Proc.new { |site| site.name_changed? }
  after_validation :geocode, if: Proc.new { |site| !site.geocoded? || site.address_changed? || site.zipcode_changed? }
  scope :public_sites, -> { where(public: true) }
  scope :condominium, -> { where(site_type: "Pied d'immeuble") }

  delegate :admin, :admin_id, to: :organisation

  EDITABLE_PARAMS = %i(
    name contact_email website_url location_information operation_conditions participation_conditions
    latitude longitude address city zipcode public site_type organisation_id
  )

  def self.editable_params
    EDITABLE_PARAMS
  end

  def full_address
    [address, city, zipcode, 'France'].join(', ')
  end

  def condominium_site?
    site_type == "Pied d'immeuble"
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

  def contact_email
    self[:contact_email].presence || organisation&.contact_email
  end

  def website_url
    self[:website_url].presence || organisation&.website_url.presence
  end
  # To decorator

  private

  def set_slug
    self.slug = name.parameterize
  end

  def set_formatted_name
    format_name = name.gsub(/compost?(\w)+/i, 'Composteur')
    format_name.prepend('Composteur ') unless format_name.split.first == 'Composteur'
    self.formatted_name = format_name
  end
end
