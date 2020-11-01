class Site < ApplicationRecord
  extend FriendlyId
  belongs_to :organisation
  geocoded_by :full_address
  after_validation :geocode, if: Proc.new { |site| !site.geocoded? || site.address_changed? || site.zipcode_changed? }
  scope :public_sites, -> { where(public: true) }
  friendly_id :name, use: :slugged

  def full_address
    [address, city, zipcode, 'France'].join(', ')
  end
end
