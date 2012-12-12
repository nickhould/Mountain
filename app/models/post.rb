class Post < ActiveRecord::Base
  attr_accessible :blog_id, :title, :url, :uid, :type, :posted_at

  belongs_to :blog


  def self.initialize_tumblr(token, secret)
    @tumblr = TumblrData.new(token, secret)
  end

  def self.create_all_from_tumblr(token, secret, blog_url)
    initialize_tumblr(token, secret)
    @tumblr.posts(blog_url)["posts"].each do |tumblr_post|
      find_or_create_from_tumblr(tumblr_post)
    end
  end

  def self.find_or_create_from_tumblr(tumblr_post)
    blog = find_by_uid(tumblr_post["id"])
    blog ? nil : create_from_tumblr(tumblr_post)
  end

  def self.create_from_tumblr(tumblr_post)
    create! do |post|
      post.url        = tumblr_post["post_url"]
      post.title      = tumblr_post["title"]
      post.uid        = tumblr_post["id"]
      post.type       = tumblr_post["type"]
      post.posted_at  = tumblr_post["date"]
    end 
  end
end
