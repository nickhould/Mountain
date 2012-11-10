require 'metrics'

class GoogleAnalytics

	def accounts
		Garb::Management::Account.all
	end

	def web_properties
		Garb::Management::WebProperty.all
	end

	def profiles
		Garb::Management::Profile.all
	end

	def profile(web_property_id="UA-23645331-1")
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

	
  
end
