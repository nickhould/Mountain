class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  helper_method :encode_url_for_params

  def authorized_user
    dashboard = current_user.dashboards.find_by_id(params[:id])
    redirect_to root_path unless dashboard
  end

  def at_least_one_dashboard
    if current_user.dashboards.count == 0
      redirect_to new_dashboard_url, notice: "Please create a dashboard."
    end
  end

  def google_authorized
    auth = current_user.authorizations.find_by_provider("google")
    redirect_to root_path unless auth
  end
  
	protected
  def encode_url_for_params(url)
  	URI.encode(Base64.encode64(url))
  end

  def decode_url_from_params(url)
  	URI.decode(Base64.decode64(url))
  end
end
