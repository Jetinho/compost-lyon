class Organisation < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :sites

  def description
    self[:description] || name
  end

  def meta_description
    self[:meta_description] || description
  end
end
