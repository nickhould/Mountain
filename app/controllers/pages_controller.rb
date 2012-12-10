require 'uri'
require 'base64'
class PagesController < ApplicationController
  before_filter :signed_in_user
  before_filter :authorized_user
  
  def show
		@dashboard = current_user.dashboards.find_by_id(params[:dashboard_id])  	
  	@dashboard.datasource(google_token, google_secret)
  	@page_path = decode_url_from_params(params[:id])
  end

protected
  def authorized_user
    dashboard = current_user.dashboards.find_by_id(params[:dashboard_id])
    redirect_to root_path unless dashboard
  end
end
