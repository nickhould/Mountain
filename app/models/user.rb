class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid

	def self.from_omniauth(auth)
		 where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
	end


	def self.create_from_omniauth(auth)
		create! do |user|
			user.provider = auth["provider"]
			user.uid = auth["uid"]
		end
	end

	def get_authentication_token
		self.oauth_token
	end


end
