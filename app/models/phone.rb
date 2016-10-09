class Phone < ActiveRecord::Base
  belongs_to :profile
  validates :phone_num, presence: true, uniqueness: true
end
