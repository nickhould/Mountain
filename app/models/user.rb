class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid, :password_confirmation, :password, :email

  has_secure_password

  has_many :dashboards
  has_many :authorizations

	def self.from_omniauth(auth, google_token, google_secret)
		where(provider: auth.provider, uid: auth.uid).first || create_from_omniauth(auth, google_token, google_secret)
	end


	def self.create_from_omniauth(auth, google_token, google_secret)
		@user = User.new
		@user.provider = auth.provider
		@user.uid = auth.uid
		@user.save
		@user
	end
end
