class SessionsController < ApplicationController

  def new
  end

	def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      @tracker.track("logged_in")
      redirect_to default_dashboard_url, notice: "Signed in"
    else
      flash[:notice] = "Bad email address or password."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    @tracker.track("logged_out")
    redirect_to root_url, notice: "Signed out!"
  end
end
