class PostDataSet < ActiveRecord::Base
  attr_accessible :notes, :uid, :post_id
  belongs_to :post

  def self.initialize_tumblr(token, secret)
    @tumblr = TumblrData.new(token, secret)
  end

  def self.create_all_from_tumblr(token, secret, blog_url)
    initialize_tumblr(token, secret)
    @tumblr.posts(blog_url)["posts"].each do |tumblr_post|
      find_or_create_from_tumblr(tumblr_post)
    end
  end

   # TODO - validate : if post && post.post_data_set.posted_at != tumblr_post["date"] 
  def self.find_or_create_from_tumblr(tumblr_post)
    post = find_from_post(tumblr_post)
    if post && post.post_data_set.posted_at != tumblr_post["date"] 
      create_from_post(tumblr_post)
    elsif !post
      post.create_from_tumblr(tumblr_post)
    end
  end

  def self.find_from_post(tumblr_post)
    post.find_by_uid(tumblr_post["id"])
  end

  def self.create_from_post(tumblr_post)
    create! do |data_set|
      data_set.uid        = tumblr_post["id"]
      data_set.notes      = tumblr_post["note_count"]
    end 
  end
end
