	require 'uri'
class Dashboard < ActiveRecord::Base
  attr_accessible :name, :web_property_id, :user_id

  belongs_to :user

	validates_presence_of :name, :web_property_id, :user_id

	# API Call
	def datasource(token, secret)
		@ga ||= GoogleAnalytics.new(token, secret)
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

# To be refactored
	def mobile_ratio
		data = {}
		profile.mobile.each do |obj|
			if obj.is_mobile == "No"
				data[:is_not_mobile] = obj.visits.to_f
			elsif obj.is_mobile == "Yes"
				data[:is_mobile] = obj.visits.to_f
			end
		end
		ratio = ( data[:is_mobile] / ( data[:is_mobile] + data[:is_not_mobile] )) * 100
		ratio.round(2)
	end


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
		ratio = ( data[:is_mobile] / ( data[:is_mobile] + data[:is_not_mobile] )) * 100
	end

	def mobile_ratio_variation
		variation = mobile_ratio - mobile_ratio_previous_period
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

	def previous_period_dates
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

	def metric(metric_name, options={})
		results = results(metric_name, options)
	end

	def results(metric_name, options)
		params = params(options)
		if options[:variation] == true
			results = variation(metric_name, params)
		else
			results = method(metric_name).call(params)
		end
	end

	def params(options)
		params = {}
		if options[:page_path]
			params[:filters] = { :page_path.eql => options[:page_path] }
		end
		params
	end

	def variation(metric_name, params)
		current_data = method(metric_name).call(params)
		params << previous_period_dates
		call(somemethod, )
	end

	def visits(params)
		profile.visits(params)
	end

	def pages(*page_path)
		page_path.present? ? params = {filters: { :page_path.eql => page_path.first }} : params = {}
		profile.pages(params).sort { |a,b| a.pageviews.to_i <=> b.pageviews.to_i}.reverse.take(10)
	end

	def mobile(*page_path)
		page_path.present? ? params = {filters: { :page_path.eql => page_path.first }} : params = {}
		profile.mobile(params)
	end

	def sources(params)
		profile.sources(params).sort { |a,b| a.visits.to_i <=> b.visits.to_i}.reverse.take(10)
	end

	def snapshot(params)
		profile.snapshot(params).first
	end

	def next_page_path(page_path)
		next_page_path = profile.nextpage(filters: { :previous_page_path.eql => page_path })
		next_page_path = next_page_path.sort { |a,b| a.pageviews.to_i <=> b.pageviews.to_i }.reverse.take(4)
	end

	def exits(*page_path)
		page_path.present? ? params = {filters: { :page_path.eql => page_path.first }} : params = {}
		exits = profile.exits(params).first
	end

	def keywords(*page_path)
		page_path.present? ? params = {filters: { :page_path.eql => page_path.first }} : params = {}
		keywords = profile.keywords(params)
		keywords = keywords.sort { |a,b| a.visits.to_i <=> b.visits.to_i }.reverse.take(5)
	end

	def pageviews(*page_path)
		page_path.present? ? params = {filters: { :page_path.eql => page_path.first }} : params = {}
		pageviews = profile.pageviews(params).first
	end
end