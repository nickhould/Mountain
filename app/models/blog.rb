class Blog < ActiveRecord::Base
  attr_accessible :authorization_id, :title, :url, :name, :written_at

  belongs_to :authorization
  has_many :posts
  has_many :dashboards
  has_many :blog_data_sets

  def self.initialize_tumblr(token, secret)
    @tumblr = TumblrData.new(token, secret)
  end


  # Posts

  def self.token
    authorization.token if respond_to?(:authorization)
  end

  def self.secret
    authorization.secret if respond_to?(:authorization)
  end

  def create_posts_from_tumblr(token=token, secret=secret)
    posts.create_all_from_tumblr(token, secret, url)
  end

  # Blogs

  def self.create_all_from_tumblr(token, secret)
    initialize_tumblr(token, secret)
    blogs = @tumblr.blogs
    unless blogs.blank?
      blogs.each do |tumblr_blog|
        find_or_create_from_tumblr(tumblr_blog)
      end
    end
  end

  def self.find_or_create_from_tumblr(tumblr_blog)
    blog = find_by_url_and_name(tumblr_blog["url"], tumblr_blog["name"])
    unless blog
      blog = create_from_tumblr(tumblr_blog)
      blog.create_data_set_from_blog(tumblr_blog)
    else
      blog.update_data_set_from_tumblr(blog, tumblr_blog)
    end
  end

  def self.create_from_tumblr(tumblr_blog)
    create! do |blog|
      blog.url        = tumblr_blog["url"]
      blog.title      = tumblr_blog["title"]
      blog.name       = tumblr_blog["name"]
      blog.written_at = tumblr_blog["updated"]
    end
  end

  def create_data_set_from_blog(tumblr_blog)
    blog_data_sets.create_from_blog(tumblr_blog)
  end

  def update_data_set_from_tumblr(blog, tumblr_blog)
    blog_data_sets.update_from_blog(blog, tumblr_blog)
  end



  # Metrics

  def total_notes
    total = 0
    if posts.any?
      posts.each do |post|
        notes_for_post = post.post_data_sets.last.notes
        total += notes_for_post.to_i
      end
    end
    total
  end

  def total_posts
    posts.any? ? posts.count : 0
  end

  def followers
    if blog_data_sets.any?
      followers = blog_data_sets.last.followers
    end
  end
end