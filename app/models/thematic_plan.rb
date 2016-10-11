class ThematicPlan < ApplicationRecord
  belogs_to: subject
  has_many: marks
  
end
