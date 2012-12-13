require 'uri' # consider moving this require to your application.rb
class Dashboard < ActiveRecord::Base
  after_save :create_all_post_from_blog
  attr_accessible :name, :web_property_id, :user_id, :blog_id
  
  belongs_to :user
  belongs_to :blog

  validates_presence_of :name, :web_property_id, :user_id, :blog_id

  # Tumblr
  def create_all_post_from_blog
    blog.create_posts_from_tumblr(user.tumblr_token, user.tumblr_secret)
  end

  def total_notes
    total = blog.total_notes
  end

  def total_posts
    blog.total_posts
  end

  def average_notes_per_post
    if total_notes > 0 && total_posts > 0
      avg = ( total_notes.to_f / total_posts.to_f ).to_f.round(2)
    else
      avg = 0
    end
  end

  def followers
    blog.followers
  end

  # Google Analytics Account Management
  def datasource(token, secret)
    @ga ||= GoogleAnalytics.new(token, secret)
  end

  def params=(params)
    @params = params
  end

  def profile
    @profile ||= @ga.profile(self.web_property_id)
  end

  def profiles
    @ga.profiles
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

  # Google Analytics Metrics

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

  def variation(metric_name, secondary_metric=nil, page_path=nil, single_metric = false)
  	if secondary_metric
  		calculate_variation(variation_with_secondary_metric(metric_name, secondary_metric, page_path)) 
  	elsif single_metric
  		calculate_variation([past_result(metric_name, page_path), present_result(metric_name, page_path)])
  	else
			calculate_variation(variation_with_metric(metric_name, page_path))
		end
  end

  def past_result(metric_name, page_path=nil)
  	results(metric_name, page_path, true)
  end

  def present_result(metric_name, page_path=nil)
		results(metric_name, page_path, false)
  end

  def var_results(metric, page_path=nil)
  	[past_result(metric, page_path), present_result(metric, page_path)]
  end

  def variation_absolute(metric_name, page_path=nil)
		calculate_absolute_variation(var_results(metric_name, page_path))
  end

  def variation_with_metric(metric_name, page_path)
  	past, present = var_results(metric_name, page_path)
  	past = past.try(metric_name)
  	present = present.try(metric_name)
  	[past, present]
  end

  def variation_with_secondary_metric(metric_name, secondary_metric, page_path = nil)
  	past, present = var_results(metric_name, page_path)
  	if past && present
  		past = past.try(secondary_metric)
  		present = present.try(secondary_metric)
  		[past, present]
  	else
  		nil
  	end
  end

  def calculate_variation(result_set)
  	past_result, present_result = result_set
  	if past_result && present_result
  		( ( ( present_result.to_f - past_result.to_f ) / past_result.to_f ) * 100 ).round(2)
  	else
  		nil
  	end
  end

  def calculate_absolute_variation(result_set)
		past_result, present_result = result_set
  	if past_result && present_result
			( present_result.to_f - past_result.to_f ).round(2)
		else
			nil
		end
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
	  if not_mobile && is_mobile
	  	(is_mobile.to_f / (not_mobile.to_f + is_mobile.to_f) * 100).round(2)
	  else
	  	nil
	  end
	end
	def mobile
	  results = profile.mobile(@params).to_a
	  # not mobile visits, mobile visits
	  if results.first && results.last
	  	[results.first.visits, results.last.visits]
	  else
	  	nil
	  end
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
