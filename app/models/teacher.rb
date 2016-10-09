class Teacher < User
  has_and_belongs_to_many :subjects, foreign_key: :user_id
  has_many :tariffications, dependent: :destroy, foreign_key: :user_id
  
  accepts_nested_attributes_for :subjects, allow_destroy: true 
  accepts_nested_attributes_for :tariffications, :reject_if => :all_blank, allow_destroy: true 
end
