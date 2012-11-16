class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid, :oauth_token
  attr_accessor :name, :oauth_token

	def self.from_omniauth(auth)
		 where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
	end


	def self.create_from_omniauth(auth)
		create! do |user|
			user.provider = auth["provider"]
			user.uid = auth["uid"]
			user.name = auth[]
	end

	def get_authentication_token
		self.oauth_token
	end

			# user = User.new    
  	# user.provider = auth[:provider]
  	# user.uid = auth[:uid]
  	
  	# user.name = auth["user"]["name"]
		
		# @test = auth[:credentials][:token]
		
		#user.oauth_token = auth[:credentials][:token].to_s
		#user.oauth_expires_at = Time.at(auth.credentials.expires_at)
		# user.save
	end
end