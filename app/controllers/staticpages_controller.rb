class StaticpagesController < ApplicationController

	before_filter :create_garb_session, only: :test
	
	def home
	end

	def login
	end

	def about
	end

	def test
	  @dashboard = current_user.dashboards.first
    @dashboard.datasource(session[:google_token], session[:google_secret])
    @dashboards = current_user.dashboards
	end

	def create_garb_session
    @ga = GoogleAnalytics.new(session[:google_token], session[:google_secret]) 
  end
end
