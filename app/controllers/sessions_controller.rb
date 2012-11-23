class SessionsController < ApplicationController

	def create
    auth = request.env["omniauth.auth"]
    google_token = session[:google_token] = auth.credentials.token
    google_secret= session[:google_secret] = auth.credentials.secret
    @user = User.from_omniauth(auth, google_token, google_secret)
    session[:user_id] = @user.id
    redirect_to root_url, notice: "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end
end
