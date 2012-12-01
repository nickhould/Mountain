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
		data_pres = object.snapshot.method(method).call
	end

	def data_prev(object, method)
		data_prev = object.snapshot_previous_period.method(method).call
	end

	def variation_positive?(object, method)
		data_pres = data_pres(object, method)
		data_prev = data_prev(object, method)
		variation = variation (data_pres, data_prev)
		variation > 0 ? true : false
	end

	def variation(data_pres, data_prev)
		variation = ( data_pres.to_i - data_prev.to_i ) / data_prev.to_i
		variation *= 100
	end

	def convert_seconds_to_time(seconds)
   total_minutes = seconds / 1.minutes
   seconds_in_last_minute = seconds - total_minutes.minutes.seconds
   "#{total_minutes}m #{seconds_in_last_minute}s"
	end
end
