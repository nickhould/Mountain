class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid

  has_many :dashboards

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
