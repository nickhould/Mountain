class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  helper_method :encode_url_for_params

  def at_least_one_dashboard
    if current_user.dashboards.count == 0
      redirect_to new_dashboard_url, notice: "Please create a dashboard."
    end
  end

  def google_authorized
    auth = current_user.authorizations.find_by_provider("google")
    redirect_to authorizations_path, notice: "Please authorize your Google Account." unless auth
  end
  
	protected
  def encode_url_for_params(url)
  	URI.encode(Base64.encode64(url))
  end

  def decode_url_from_params(url)
  	URI.decode(Base64.decode64(url))
  end

  def google_token
    current_user.authorizations.find_by_provider("google").token
  end

  def google_secret
    current_user.authorizations.find_by_provider("google").secret
  end
end
