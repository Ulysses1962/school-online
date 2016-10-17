class Subject < ActiveRecord::Base
  has_many :tariffications
  has_many :marks
  has_many :ranks
  has_many :thematicplans
  belongs_to :school

  validates :name, presence: true

  scope :in_school, -> (school) { where('school_id = ?', school) }
end
