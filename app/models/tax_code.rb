class TaxCode < ActiveRecord::Base
  belongs_to :profile
  validates :ptc, presence: true, uniqueness: true
end
