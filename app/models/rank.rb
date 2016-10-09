class Rank < ApplicationRecord
  CLASS_LEVEL_RANK          = 1
  PARALLEL_LEVEL_RANK       = 2
  SCHOOL_LEVEL_RANK         = 3
  CITY_LEVEL_RANK           = 4
  CLASS_LEVEL_SUBJ_RANK     = 5
  PARALLEL_LEVEL_SUBJ_RANK  = 6

  belongs_to :student
  validates_inclusion_of :rank_type, :in => [
    CLASS_LEVEL_RANK, CLASS_LEVEL_SUBJ_RANK, 
    PARALLEL_LEVEL_RANK, PARALLEL_LEVEL_SUBJ_RANK, 
    SCHOOL_LEVEL_RANK, CITY_LEVEL_RANK] 

end
