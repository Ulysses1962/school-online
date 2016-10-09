class Subject < ActiveRecord::Base
  has_and_belongs_to_many :teachers
  has_many  :tariffications
  has_many :marks
  has_many :ranks
  
  validates :name, presence: true
  validates :level, presence: true

  scope :in_class, -> (level) { where('level = ?', level) }
end
