class Site < ApplicationRecord
  extend FriendlyId
  belongs_to :organisation
  geocoded_by :full_address
  before_validation :set_formatted_name#, if: Proc.new { |site| site.name_changed? }
  friendly_id :formatted_name, use: :slugged
  after_validation :geocode, if: Proc.new { |site| !site.geocoded? || site.address_changed? || site.zipcode_changed? }
  scope :public_sites, -> { where(public: true) }

  def full_address
    [address, city, zipcode, 'France'].join(', ')
  end

  private

  def set_formatted_name
    format_name = name.gsub(/compost?(\w)+/i, 'Composteur')
    format_name.prepend('Composteur ') unless format_name.split.first == 'Composteur'
    self.formatted_name = format_name
  end
end
