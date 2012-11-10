class SessionsController < ApplicationController

	def create
   #     raise request.env["omniauth.auth"].to_yaml

    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.from_omniauth(auth)


  	end

end
