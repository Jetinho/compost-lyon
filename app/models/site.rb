class Site < ApplicationRecord
  belongs_to :organisation
  geocoded_by :full_address
  after_validation :geocode, if: Proc.new { |site| !site.geocoded? || site.address_changed? || site.zipcode_changed? }
  scope :public_sites, -> { where(public: true) }

  def full_address
    [address, city, zipcode, 'France'].join(', ')
  end
end
