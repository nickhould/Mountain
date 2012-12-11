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
		@tumblr = TumblrData.new(tumblr_token, tumblr_secret)
		@blogs = @tumblr.blogs
	end

	def demo
	end

	def demo_page
	end

	def create_blogs
		configure_tumblr
		client = Tumblr.new
		blogs = client.info["user"]["blogs"]	
		blogs.each do |blog|
			Tumblog.create(
				url: blog["url"],
				title: blog["title"],
				followers: blog["followers"],
				posts: blog["posts"],
				updated: blog["updated"]
				)
		end
	end
end
