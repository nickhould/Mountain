class Post < ActiveRecord::Base
  attr_accessible :blog_id, :title, :url, :uid, :type_of, :posted_at

  belongs_to :blog
  has_many :post_data_sets

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
    post = find_by_uid(tumblr_post["id"])
    if post.blank?
      post = create_from_tumblr(tumblr_post)
      post.create_data_set_from_post(tumblr_post) 
    else
      post_data_sets.find_or_create_from_tumblr(tumblr_post)
    end
  end

  def self.create_from_tumblr(tumblr_post)
    create! do |post|
      post.url        = tumblr_post["post_url"]
      post.title      = tumblr_post["title"]
      post.uid        = tumblr_post["id"]
      post.type_of    = tumblr_post["type"]
      post.posted_at  = tumblr_post["date"]
    end 
  end

  def create_data_set_from_post(tumblr_post)
    post_data_sets.create_from_post(tumblr_post)
  end

  def update_data_set_from_tumblr
    post_data_sets.create_all_from_tumblr(token, secret, blog_url)
  end
end
