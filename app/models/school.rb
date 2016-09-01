class School < ActiveRecord::Base
  has_many :profiles

  validates :school_code, presence: true, uniqueness: true
  validates :school_email, presence: true, uniqueness: true
  validates :school_name, presence: true
  validates :school_address_string, presence: true
  validates :school_phone, presence: true, uniqueness: true

  geocoded_by :school_address_string
  after_validation :geocode
end
