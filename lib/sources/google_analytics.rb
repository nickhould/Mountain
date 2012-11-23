require 'metrics'

class GoogleAnalytics

	def accounts
		Garb::Management::Account.all
	end

	def web_properties(garbsession)
		collection = []
		properties = Garb::Management::WebProperty.all(garbsession)
		properties.each do |p|
			property = OpenStruct.new
			property.name = p.entry["name"]
			property.id = p.entry["id"]
			collection << propertys
		end
		return collection
	end

	def profiles
		Garb::Management::Profile.all
	end

	def profile(web_property_id="UA-27991223-1")
		profile = Garb::Management::Profile.all.detect do |p| 
			p.web_property_id == web_property_id
		end
	end

	def goals
		Garb::Management::Goal.all
	end

	#Metrics
	def validated_result(metric, raw_result)
		result = raw_result.first
		result.nil? ? 0 : result.method(metric).call.to_i
	end

	def per_day(metric)
		results = Hash.new
		date = Date.today
		30.times do |i|
			raw_result = profile.method(metric).call(start_date: date, end_date: date)
			results[date] = validated_result(metric, raw_result)
			date -= 1
		end
		results
	end

	# Oauth1

	# def garbsession(consumer, google_token, google_secret)
	# 	garbsession = Garb::Session.new
	# 	garbsession.access_token = OAuth::AccessToken.new(consumer, google_token, google_secret)
	# 	garbsession
	# end

	# def profile_selection(garbsession)
	# 	# Once we have an OAuth::AccessToken constructed, do fun stuff with it
	# 	ga_id = "UA-XXXXXXX-X"
	# 	profile = Garb::Management::Profile.all(garbsession).detect {|p| p.web_property_id == ga_id}
	# 	ga_monthly = GoogleAnalyticsDate.results(profile, :start_date => (Date.today - 30), :end_date => Date.today, :sort => :date)
	# 	return ga_monthly
	# end
end
