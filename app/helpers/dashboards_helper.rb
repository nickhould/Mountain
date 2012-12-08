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
	  "#{result.year}, #{result.month - 1}, #{result.day}"
	end

	def arrow_for_single_metric(metric)
	  if metric
		  if metric.to_i > 0 
		    return ("uparrow.svg")
		  elsif metric.to_i < 0
		    return ("downarrow.svg")
		  end
		else
			nil
		end
	end

	# def arrow(object, method)
	#   variation_positive?(object, method) ? 
	# end

	def arrow(variation)
		if variation
			positive?(variation) ? "uparrow.svg" : "downarrow.svg"
		else
			"circle.svg"
		end	
	end

	def positive?(number)
		number.to_f > 0 ? true : false
	end

	def format_var(variation)
		if variation
			if variation.to_f != 0
				if positive?(variation)
					"+" + variation.to_s + "%"
				else
					variation.to_s + "%"
				end
			end
		else
			"No variation"
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



	def negative?(number)
		number < 0 ? true : false
	end

	def variation_positive?(object, method)
		positive? variation(object, method)
	end

	def variation_negative?(object, method)
		negative? variation(object, method)
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
		variation.round(2).to_s + "%"
	end

	def convert_seconds_to_time(seconds)
    total_minutes = seconds / 1.minutes
    seconds_in_last_minute = seconds - total_minutes.minutes.seconds
    "#{total_minutes}m #{seconds_in_last_minute}s"
	end

	def format_time(seconds)
		(Time.mktime(0)+seconds.to_f).strftime("%M:%S")
	end
end
