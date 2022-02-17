class Site < ApplicationRecord
  extend FriendlyId
  belongs_to :organisation
  geocoded_by :full_address
  validates :name, presence: true
  validates :slug, presence: true

  friendly_id :formatted_name, use: :slugged
  before_validation :set_formatted_name, if: proc { |site| site.name_changed? }
  before_validation :set_slug
  after_validation :geocode, if: proc { |site| !site.geocoded? || site.address_changed? || site.zipcode_changed? }
  scope :public_sites, -> { where(public: true) }
  scope :condominium, -> { where(site_type: "Pied d'immeuble") }
  scope :metropole_funding, -> { where(metropole_funding: true) }

  delegate :manager, :manager_id, to: :organisation

  ADMIN_EDITABLE_PARAMS = %i[
    name contact_email website_url location_information operation_conditions participation_conditions
    slug latitude longitude address city zipcode public site_type organisation_id
  ]

  EDITABLE_PARAMS = %i[
    contact_email website_url location_information operation_conditions participation_conditions
    latitude longitude address city zipcode organisation_id
  ]

  def self.admin_editable_params
    ADMIN_EDITABLE_PARAMS
  end

  def self.editable_params
    EDITABLE_PARAMS
  end

  def full_address
    [address, city, zipcode, 'France'].join(', ')
  end

  def condominium_site?
    site_type == "Pied d'immeuble"
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

  private

  def set_slug
    self.slug = SiteNameFormatter.format_slug(formatted_name, :formatted_name)
  end

  def set_formatted_name
    self.formatted_name = SiteNameFormatter.format(name)
  end
end
