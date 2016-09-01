class Subject < ActiveRecord::Base
  has_and_belongs_to_many :teachers
  has_many  :tariffications
  validates :name, presence: true
  validates :level, presence: true
  
end
