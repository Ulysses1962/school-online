class Profile < ActiveRecord::Base
  belongs_to  :user
  has_one     :address, dependent: :destroy, autosave: true
  has_one     :tax_code, dependent: :destroy, autosave: true
  has_many    :phones, dependent: :destroy, autosave: true
  has_one     :personal_file, dependent: :destroy, autosave: true

  accepts_nested_attributes_for :phones, :reject_if => proc {|attr| attr['phone_num'].blank?}, allow_destroy: true
  accepts_nested_attributes_for :personal_file, :reject_if => proc {|attr| attr['personal_file_code'].blank?}, allow_destroy: true
  accepts_nested_attributes_for :address, :reject_if => proc {|attr| attr['address_string'].blank?}, allow_destroy: true
  accepts_nested_attributes_for :tax_code, :reject_if => proc {|attr| attr['ptc'].blank?}, allow_destroy: true

end
