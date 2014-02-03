class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  helper_method :encode_url_for_params, :default_dashboard_url
  before_filter :initialize_tracker
  after_filter :update_flash_with_tracker

  def initialize_tracker
    @tracker = Track.new
  end

  def update_flash_with_tracker
    flash[:track] = @tracker.events
  end


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

  def just_signed_up
    flash[:just_signed_up]
  end

  def authorized_all_providers
    tumblr_authorized? ? true : false
  end

  def can_access_dashboard
    unless authorized_all_providers || just_signed_up
      redirect_to authorizations_path, notice: "Please authorize your Google and Tumblr Account."
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
    redirect_to default_dashboard_url if signed_in?
  end

	protected
  def encode_url_for_params(url)
  	URI.encode(Base64.encode64(url))
  end

  def decode_url_from_params(url)
  	URI.decode(Base64.decode64(url))
  end

  def google_token
    current_user.authorizations.find_by_provider("google").token if google_authorized?
  end

  def google_secret
    current_user.authorizations.find_by_provider("google").secret if google_authorized?
  end

  def tumblr_token
    current_user.authorizations.find_by_provider("tumblr").token if tumblr_authorized?
  end

  def tumblr_secret
    current_user.authorizations.find_by_provider("tumblr").secret if tumblr_authorized?
  end
end
