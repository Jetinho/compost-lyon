class Organisation < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :sites

  EDITABLE_PARAMS = %i(name email website_url phone_number description)

  def self.editable_params
    EDITABLE_PARAMS
  end

  def description
    self[:description] || name
  end

  def meta_description
    self[:meta_description] || description
  end

  def nb_sites
    sites.count
  end
end
