class Organisation < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :admin, class_name: 'User', foreign_key: :user_id
  has_many :sites
  has_many :sites_basic_data, -> { select(:id, :name, :organisation_id)}, class_name: 'Site'

  SUPERADMIN_EDITABLE_PARAMS = %i(name email website_url phone_number description)
  EDITABLE_PARAMS = %i(email website_url phone_number description)

  def self.superadmin_editable_params
    SUPERADMIN_EDITABLE_PARAMS
  end

  def self.editable_params
    EDITABLE_PARAMS
  end

  def admin_id
    user_id
  end

  def description
    self[:description] || name
  end

  def meta_description
    description.first(158) # limit characters according to SEO best practices
  end

  def nb_sites
    sites_basic_data.size
  end
end
