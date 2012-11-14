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
end
