class Address < ActiveRecord::Base
  belongs_to :profile
  validates :address_string, presence: true
  # Address Geocoding
  geocoded_by :address_string
  after_validation :geocode
end
