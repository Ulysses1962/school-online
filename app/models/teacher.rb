class Teacher < User
  has_many :tariffications, dependent: :destroy, foreign_key: :user_id
  accepts_nested_attributes_for :tariffications, :reject_if => :all_blank, allow_destroy: true 
end
