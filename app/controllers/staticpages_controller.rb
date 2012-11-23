class StaticpagesController < ApplicationController

	before_filter :set_oauth

	def home
    if @authorized
      begin
        @profiles = Garb::Management::Profile.all(@garbsession)

        start_date = Date.today - 15
        start_date = Date.parse(params[:date]) if params[:date].present?

        gen_report(start_date) if params[:profile].present?
      rescue Garb::DataRequest::ClientError => e
        @message = e.message
        render 'error'
      end
    end
	end

	def login
		
	end

	# Test for Google OAuth1 
	def set_oauth
		api_key = "tKHc-DDjWZu3mern4k1u7ndN"
		if session[:google_token] and session[:google_secret]
		  consumer = OAuth::Consumer.new('472837297406.apps.googleusercontent.com', api_key, {
		    :site => 'https://www.google.com',
		    :request_token_path => '/accounts/OAuthGetRequestToken',
		    :access_token_path => '/accounts/OAuthGetAccessToken',
		    :authorize_path => '/accounts/OAuthAuthorizeToken'
		  })
		  @garbsession = Garb::Session.new
      @garbsession.access_token = OAuth::AccessToken.new(consumer, session[:google_token], session[:google_secret])
      @authorized = true
		end
	end
end
