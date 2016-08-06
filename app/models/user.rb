class User < ApplicationRecord

  has_many :recipes
  has_many :likes

  # to make user can vote
  acts_as_voter

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable	

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end
  
  # override devise look up to give username and email valid on login
  def self.find_for_database_authentication(warden_conditions)
  	conditions = warden_conditions.dup
  	if login = conditions.delete(:login)
  	  where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  	elsif conditions.has_key?(:username) || conditions.has_key?(:email)
  	  where(conditions.to_hash).first
  	end
  end

  # to validate if user has empty space on login or sign up
  # validate :check_empty_space

  # def check_empty_space
  #   if self.attribute.match(/\s+/)
  #     errors.add(:attribute, "No empty spaces please :(")
  #   end
  # end

  # to be very careful with username validation, because there might be conflict between username and email. 
  validate :validate_username

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  # this is to upload user avatar
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/assets/images/missing-user.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

end
