class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid, :oauth_token
  attr_accessor :name, :oauth_token

	def self.from_omniauth(auth)
		user = User.new    
  		user.provider = auth[:provider]
  		user.uid = auth[:uid]
  		# user.name = auth["user"]["name"]
		@test = auth[:credentials][:token]
		#user.oauth_token = auth[:credentials][:token].to_s
		#user.oauth_expires_at = Time.at(auth.credentials.expires_at)
		user.save
		user
	end

	def get_authentication_token
	self.oauth_token
	end
end