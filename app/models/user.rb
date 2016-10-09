class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_and_belongs_to_many :roles
  has_one :profile, dependent: :destroy, autosave: true
  belongs_to :school

  accepts_nested_attributes_for :profile, allow_destroy: true
  accepts_nested_attributes_for :roles, allow_destroy: true
  
  
  devise :database_authenticatable, :registerable, :recoverable, :trackable, :validatable

  validates :username, presence: true, uniqueness: true       
  validates :school_id, presence: true, uniqueness: false
  
  
  attr_accessor :sign_token

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if sign_token = conditions.delete(:sign_token)
      where(conditions.to_hash).where(["username = :value OR email = :value", { :value => sign_token }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end

  def role?(role)
    return !!self.roles.find_by_rolename(role)
  end 

  def self.get_password
    Devise.friendly_token.first(8)
  end   
end
