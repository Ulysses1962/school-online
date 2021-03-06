class Mark < ApplicationRecord
  ACADEMIC_YEAR_START_MONTH = 9
  ACADEMIC_YEAR_START_DAY = 1

  THEMATIC_MARK = 2
  SEMESTER_MARK = 3

  belongs_to :student
  belongs_to :subject

  validates :mark, presence: true
  validates :mark_type, presence: true
  validates_inclusion_of :mark_type, :in => [THEMATIC_MARK, SEMESTER_MARK]

  scope :this_year_marks, lambda {where("created_at >= ? AND created_at <= ?", Mark.academic_year_start_date, DateTime.now)}  
 
  def self.academic_year_start_date
    now  = DateTime.now
    year = now.year if now.month >= 9 else now.year - 1 
    DateTime.new(year, ACADEMIC_YEAR_START_MONTH, ACADEMIC_YEAR_START_DAY)
  end  

end
