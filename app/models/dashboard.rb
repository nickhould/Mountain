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

	def pageviews_per_page(page_path)
		pageviews = profile.pageviews(filters: { :page_path.eql => page_path }).first
	end

	def sources_per_page(page_path)
		unsorted_sources = profile.sources(filters: { :page_path.eql => page_path })
		sources = unsorted_sources.sort { |a,b| a.visits.to_i <=> b.visits.to_i }.reverse.take(10)
	end

	def snapshot_per_page(page_path, reload = false)
		if reload
			@snapshot = profile.snapshotperpage(filters: { :page_path.eql => page_path }).first		 	
		else
			@snapshot ||= profile.snapshotperpage(filters: { :page_path.eql => page_path }).first		 	
		end
	end

	def next_page_path(page_path)
		next_page_path = profile.nextpage(filters: { :previous_page_path.eql => page_path })
		next_page_path = next_page_path.sort { |a,b| a.pageviews.to_i <=> b.pageviews.to_i }.reverse.take(4)
	end

	def exits_per_page(page_path)
		exits = profile.exits(filters: { :page_path.eql => page_path }).first
	end

	def keywords_per_page(page_path)
		keywords = profile.keywords(filters: { :page_path.eql => page_path})
		keywords = keywords.sort { |a,b| a.visits.to_i <=> b.visits.to_i }.reverse.take(5)
	end
end