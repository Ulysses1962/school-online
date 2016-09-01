class PersonalFile < ActiveRecord::Base
  belongs_to :profile
  validates :personal_file_code, presence: true, uniqueness: true
end
