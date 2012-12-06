require 'uri' # consider moving this require to your application.rb
class Dashboard < ActiveRecord::Base
  attr_accessible :name, :web_property_id, :user_id
  
  belongs_to :user

  validates_presence_of :name, :web_property_id, :user_id

  # API Call
  def datasource(token, secret)
    @ga ||= GoogleAnalytics.new(token, secret)
  end

  def params=(params)
    @params = params
  end

  def profile
    @profile ||= @ga.profile(self.web_property_id)
  end

  def accounts
    @ga.accounts
  end

  def web_property
    @ga.web_property(self.web_property_id)
  end

  def web_properties
    @ga.web_properties	
  end

  def previous_period_dates
    {
      start_date: 61.days.ago,
      end_date: 31.days.ago,
    }
  end



# To be refactored

	def mobile_ratio_previous_period
		dates = previous_period_dates
		data = {}
		profile.mobile(dates).each do |obj|
			if obj.is_mobile == "No"
				data[:is_not_mobile] = obj.visits.to_f
			elsif obj.is_mobile == "Yes"
				data[:is_mobile] = obj.visits.to_f
			end
		end
		( data[:is_mobile] / ( data[:is_mobile] + data[:is_not_mobile] )) * 100
	end

	def mobile_ratio_variation
		mobile_ratio - mobile_ratio_previous_period
	end

	def formatted_mobile_variation
		variation = mobile_ratio_variation
		if variation > 0
			variation = "+" + variation.round(2).to_s + "%"
			return variation
		else
			variation = variation.round(2).to_s + "%"
			return variation.to_s
		end
	end

	def params_previous_period_dates
		previous_period_dates = {}
		end_date = previous_period_dates[:end_date] = 31.days.ago
		previous_period_dates[:start_date] = 30.days.ago(end_date)
		previous_period_dates
	end

	def snapshot_previous_period
		dates = previous_period_dates
		start_date = dates[:start_date]
		end_date = dates[:end_date]
		profile.snapshot(start_date: start_date, end_date: end_date).first
	end


# metrics

	def results(metric_name, page_path = nil, variation = false)
    params = params(page_path, variation)
	  method(metric_name).call
	end

	def params(page_path = nil, variation = false)
    params = {}
    params = params.merge(previous_period_dates) if variation
    params[:filters] = page_path_filter(page_path) if page_path
    @params = params
  end

  def variation(metric_name, secondary_metric=nil, page_path=nil)
  	if secondary_metric
  		calculate_variation(variation_with_secondary_metric(metric_name, secondary_metric, page_path)) 
  	else
			calculate_variation(variation_results(metric, page_path))
		end
  end

  def past_result(metric, page_path=nil)
  	results(metric_name, page_path, true)
  end

  def present_result(metric, page_path=nil)
		results(metric_name, page_path, false)
  end

  def variation_results(metric, page_path=nil)
  end

  def variation_absolute(metric_name, page_path=nil)
		calculate_absolute_variation(variation_results_single(metric_name, page_path))
  end

  def variation_method_calling

  end

  def variation_results_single(metric_name, page_path)
  	past_result = results(metric_name, page_path, true)
  	present_result = results(metric_name, page_path, false)
  	[past_result, present_result]
  end

  def variation_results(metric_name, page_path)
  	past_result = results(metric_name, page_path, true).method(metric_name).call
  	present_result = results(metric_name, page_path, false).method(metric_name).call
  	[past_result, present_result]
  end

  def variation_with_secondary_metric(metric_name, secondary_metric, page_path = nil)
  	past_result = results(metric_name, page_path, true).method(secondary_metric).call
  	present_result = results(metric_name, page_path, false).method(secondary_metric).call
  	[past_result, present_result]
  end

  def calculate_variation(result_set)
  	past_result, present_result = result_set
  	( ( ( present_result.to_f - past_result.to_f ) / past_result.to_f ) * 100 ).round(2)
  end

  def calculate_absolute_variation(result_set)
		past_result, present_result = result_set
		( present_result - past_result ).round(2)
  end

  def page_path_filter(path)
    { :page_path.eql => path }
  end

	def visits
		profile.visits(@params)
	end

	def pages
		profile.pages(@params).sort { |a,b| a.pageviews.to_i <=> b.pageviews.to_i}.reverse.take(10)
	end

	def mobile_ratio
	  not_mobile, is_mobile = mobile
    (is_mobile.to_f / (not_mobile.to_f + is_mobile.to_f) * 100).round(2)
	end
	def mobile
	  results = profile.mobile(@params).to_a
	  # not mobile visits, mobile visits
	  [results.first.visits, results.last.visits]
  end
	
	def sources
		profile.sources(@params).sort { |a,b| a.visits.to_i <=> b.visits.to_i}.reverse.take(10)
	end

	def snapshot
		profile.snapshot(@params).first
	end

	def next_page_path
		next_page_path = profile.nextpage(@params)
		next_page_path = next_page_path.sort { |a,b| a.pageviews.to_i <=> b.pageviews.to_i }.reverse.take(4)
	end

	def exits
	  profile.exits(@params).first
	end

	def keywords
	  keywords = profile.keywords(@params)
	  keywords.sort { |a,b| a.visits.to_i <=> b.visits.to_i }.reverse.take(5)
	end

	def pageviews
	  profile.pageviews(@params).first
	end
end
