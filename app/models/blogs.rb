class Blogs < ActiveRecord::Base
  attr_accessible :authorization_id, :followers, :posts, :title, :update, :url

  def initialize_tumblr(token, secret)
    @tumblr = TumblrData.new(token, secret)
  end

  # def self.from_tumblr
  #   @tumblr.blogs.each do |blog|
  #     create(
  #       url: blog["url"],
  #       title: blog["title"],
  #       followers: blog["followers"],
  #       posts: blog["posts"],
  #       updated: blog["updated"]
  #       )
  #   end
  # end    

end

