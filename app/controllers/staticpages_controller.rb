class StaticpagesController < ApplicationController

	before_filter :create_garb_session, only: :test
	
	def home
	end

	def login
	end

	def about
	end

	def test
	end

	def create_garb_session
    @ga = GoogleAnalytics.new(session[:google_token], session[:google_secret]) 
  end
end
