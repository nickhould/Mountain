class SessionsController < ApplicationController

	def create
        # raise request.env["omniauth.auth"].to_yaml

   	auth = request.env["omniauth.auth"]
   		
   		if User.find_by_provider_and_uid(auth["provider"], auth["uid"])
   			user =	User.find_by_provider_and_uid(auth["provider"], auth["uid"])
	  	else		
    		user = User.from_omniauth(auth)
		end
    	end

end
