require 'uri'
class Dashboard < ActiveRecord::Base
  attr_accessible :name, :web_property_id, :user_id

  belongs_to :user

	validates_presence_of :name, :web_property_id, :user_id

	# API Calls

	def datasource(token, secret)
		@ga ||= GoogleAnalytics.new(token, secret)
	end

	def profile
		@profile ||= @ga.profile(self.web_property_id)
	end

	def visits
		profile.visits
	end

	def sources
		profile.sources.sort { |a,b| a.visits.to_i <=> b.visits.to_i}.reverse.take(10)
	end

	def pages
		profile.pages.sort { |a,b| a.pageviews.to_i <=> b.pageviews.to_i}.reverse.take(10)
	end

	def snapshot
		profile.snapshot.first
	end

	def sources_per_page(page_path)
		sources = profile.sources(filters: { :page_path.eql => page_path })
		sources = sources.sort { |a,b| a.visits.to_i <=> b.visits.to_i}.reverse.take(10)
	end
end


	# def data(web_property_id)
	# 	data = OpenStruct.new
	# 	ga = profile(web_property_id)
	# 	data.visits = ga.visits
	# 	data.sources = ga
	# 	data.pages = ga
	# 	data.snapshot = ga.snapshot.first
	# 	data
	# end