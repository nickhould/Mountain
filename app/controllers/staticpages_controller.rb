class StaticpagesController < ApplicationController
	
	def home
	end

	def login
	end

	def about
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
	end

	def demo_page
	end

	def landing
	end
end
