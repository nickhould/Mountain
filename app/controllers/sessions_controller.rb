class SessionsController < ApplicationController

  def new
  end

	def create
    auth = request.env["omniauth.auth"]
    @user = User.from_omniauth(auth)
    if @user
      log_in(session)
      redirect_to default_dashboard_url, notice: "Signed in"
    else
      flash[:notice] = "Bad email address or password."
      render 'new'
    end
  end

  def destroy
    log_out(session)
    redirect_to root_url, notice: "Signed out!"
  end


  protected
  def log_in(session)
    session[:user_id] = @user.id
    @tracker.track("logged_in")
  end

  def log_out(session)
    session[:user_id] = nilo
    @tracker.track("logged_out")
  end
end
