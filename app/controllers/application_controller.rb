class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  helper_method :encode_url_for_params, :default_dashboard_url

  def at_least_one_dashboard
    if current_user.dashboards.count == 0
      redirect_to new_dashboard_url
    end
  end

  def tumblr_authorized?
    current_user.authorizations.find_by_provider("tumblr") ? true : false 
  end

  def google_authorized?
    current_user.authorizations.find_by_provider("google") ? true : false
  end

  def authorized_all_providers
    unless google_authorized? && tumblr_authorized?
      redirect_to authorizations_path, notice: "Please authorize your Google Account."
    end 
  end

  def default_dashboard_url
    if current_user && current_user.dashboards.first && current_user.dashboards.first.id
      dashboard_url(current_user.dashboards.first.id)
    else
        new_dashboard_url
    end
  end

  def already_signed_in
    redirect_to default_dashboard_url if current_user 
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
