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

	def negative?(number)
		number < 0 ? true : false
	end

	def format_positive_variation(variation)
		"+" + variation.round(2).to_s + "%"
	end

	def format_negative_variation(variation)
		variation.round(2).to_s + "%"
	end

	def format_time(seconds)
		(Time.mktime(0)+seconds.to_f).strftime("%M:%S")
	end
end
