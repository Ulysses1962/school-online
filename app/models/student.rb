class Student < User
  has_many :marks
  has_many :ranks

  scope :in_class, -> (level, parallel, school) { joins(:profile).where('school_id = ? AND academic_class = ? AND academic_parallel = ?', school, level, parallel) }
  scope :in_parallel, -> (level, school) { joins(:profile).where('school_id = ? AND academic_class = ?', school, level) }
end
