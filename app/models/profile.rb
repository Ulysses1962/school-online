class Profile < ActiveRecord::Base
  belongs_to  :user
  has_many    :phones, dependent: :destroy, autosave: true
  
  accepts_nested_attributes_for :phones, :reject_if => proc {|attr| attr['phone_num'].blank?}, allow_destroy: true

  validates :address_string, presence: true
  # Address Geocoding
  geocoded_by :address_string
  after_validation :geocode
end
