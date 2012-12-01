module DashboardsHelper
	def render_js_array(results, element)
		rendered_array = []
		results.each do |result|
			rendered_array << result.method(element).call.to_i
		end
		rendered_array.to_json
	end

	def render_point_start(results)
		result = results.first.date.to_date
		start = "#{result.year}, #{result.month - 1}, #{result.day}" 
	end


	def arrow(object, method)
		if variation_positive?(object, method)
			return ("uparrow.svg")
		else
			return ("downarrow.svg")
		end
	end

	def data_pres(object, method)
		object.snapshot.method(method).call
	end

	def data_prev(object, method)
		object.snapshot_previous_period.method(method).call
	end

	def data(object, method)
		data = {}
		data[:pres] = data_pres(object, method).to_f
		data[:prev] = data_prev(object, method).to_f
		data
	end

	def variation_positive?(object, method)
		variation = variation(object, method)
		variation > 0 ? true : false
	end

	def variation_negative?(object, method)
		variation = variation(object, method)
		variation < 0 ? true : false
	end

	def variation(object, method)
		data = data(object, method)
		variation = ( data[:pres] - data[:prev] ) / data[:prev]
		variation *= 100
	end

	def formatted_variation(object, method)
		variation = variation(object, method)
		if variation_positive?(object, method)
			format_positive_variation(variation)
		else
			format_negative_variation(variation)
		end
	end

	def format_positive_variation(variation)
		"+" + variation.round(2).to_s + "%"
	end

	def format_negative_variation(variation)
		variation = "-" + variation.round(2).to_s + "%"
	end

	def convert_seconds_to_time(seconds)
    total_minutes = seconds / 1.minutes
    seconds_in_last_minute = seconds - total_minutes.minutes.seconds
    "#{total_minutes}m #{seconds_in_last_minute}s"
	end
end
