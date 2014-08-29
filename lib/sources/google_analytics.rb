require 'metrics'

class GoogleAnalytics
	def initialize(authorization)
    Garb::Session.access_token = OAuthManager.new(authorization).access_token
	end

	def accounts
		Garb::Management::Account.all
	end

	def web_properties
		Garb::Management::WebProperty.all()
	end

	def web_property(web_property_id)
		Garb::Management::WebProperty.all.detect do |p|
			p.id == web_property_id
		end
	end

	def profiles
  	Garb::Management::Profile.all
	end

	def profile(web_property_id)
		Garb::Management::Profile.all.detect do |p|
			p.web_property_id == web_property_id
		end
	end

	def goals
		Garb::Management::Goal.all
	end
end