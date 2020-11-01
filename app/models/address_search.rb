class AddressSearch < ApplicationRecord
  geocoded_by :name
  after_validation :geocode
end
