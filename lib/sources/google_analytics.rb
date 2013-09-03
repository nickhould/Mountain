require 'metrics'

class GoogleAnalytics

	def initialize(token, secret)
    @token = token
    @secret = secret
	end

	def accounts
		Garb::Management::Account.all(garbsession)
	end

	def web_properties
		Garb::Management::WebProperty.all(garbsession)
	end

	def web_property(web_property_id)
		Garb::Management::WebProperty.all(garbsession).detect do |p|
			p.id == web_property_id
		end
	end

	def profiles
  	Garb::Management::Profile.all(garbsession)
	end

	def profile(web_property_id)
		Garb::Management::Profile.all(garbsession).detect do |p|
			p.web_property_id == web_property_id
		end
	end

	def goals
		Garb::Management::Goal.all(garbsession)
	end

	def garbsession
		api_key = "tKHc-DDjWZu3mern4k1u7ndN"
    consumer = OAuth::Consumer.new('472837297406.apps.googleusercontent.com', api_key, {
        :site => 'https://www.google.com',
        :request_token_path => '/accounts/OAuthGetRequestToken',
        :access_token_path => '/accounts/OAuthGetAccessToken',
        :authorize_path => '/accounts/OAuthAuthorizeToken'
      })
    garbsession = Garb::Session.new
    garbsession.access_token = OAuth::AccessToken.new(consumer, @token, @secret)
    garbsession
	end

  def access_token
    garbsession.access_token
  end
end