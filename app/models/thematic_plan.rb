class ThematicPlan < ApplicationRecord
  belogs_to: subject
  has_many: marks
  
  accepts_nested_attributes_for :subjects
  
end
