class StaticpagesController < ApplicationController

	def home
		@tracker.track("viewed_home_page")
	end

	def login
		@tracker.track("viewed_login_page")
	end

	def about
		@tracker.track("viewed_about_page")
	end

	def test
		# client = Tumblr.new
		# @posts = client.posts("chicagohistorymuseum.tumblr.com", offset: 50, limit: 50)
		tumblr = TumblrData.new(tumblr_token, tumblr_secret)
		# current_user.create_blogs_from_tumblr(tumblr_token, tumblr_secret)
		@blogs = tumblr.all_posts("http://chicagohistorymuseum.tumblr.com/")
		# @blog = current_user.blogs_from_tumblr.first
		# @posts = @blog.create_posts_from_tumblr(tumblr_token, tumblr_secret)
	end

	def test_keep
		current_user.create_blogs_from_tumblr(tumblr_token, tumblr_secret)
	end

	def demo
		@tracker.track("viewed_demo")
	end

	def demo_page
		@tracker.track("viewed_second_demo_page")
	end

	def landing
		@tracker.track("viewed_landing_page")
	end
end
