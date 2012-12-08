class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid, :password_confirmation, :password, :email

  has_secure_password

  has_many :dashboards
  has_many :authorizations


end
