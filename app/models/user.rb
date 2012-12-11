class User < ActiveRecord::Base
  attr_accessible :name, :password_confirmation, :password, :email

  has_secure_password
  has_many :dashboards
  has_many :authorizations

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                
end