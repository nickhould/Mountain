class Blog < ActiveRecord::Base
  attr_accessible :authorization_id, :title, :update, :url, :name

  belongs_to :authorization
  has_many :posts
  has_many :dashboards

  def self.initialize_tumblr(token, secret)
    @tumblr = TumblrData.new(token, secret)
  end

  def self.create_all_from_tumblr(token, secret)
    initialize_tumblr(token, secret)
    blogs = @tumblr.blogs
    unless blogs.empty?
      blogs.each do |tumblr_blog|
        find_or_create_from_tumblr(tumblr_blog)
      end
    end
  end

  def self.find_or_create_from_tumblr(tumblr_blog)
    blog = find_by_url_and_name(parse_url(tumblr_blog["url"]), tumblr_blog["name"])
    blog ? nil : create_from_tumblr(tumblr_blog)
  end

  def self.create_from_tumblr(tumblr_blog)
    create! do |blog|
      blog.url        = parse_url(tumblr_blog["url"])
      blog.title      = tumblr_blog["title"]
      blog.name       = tumblr_blog["name"]
      blog.written_at = tumblr_blog["updated"]
    end
  end

  def create_posts_from_tumblr(token, secret)
    posts.create_all_from_tumblr(token, secret, url)
  end

  def self.parse_url(url)
    url = Domainatrix.parse(url)
    url.subdomain + url.host
  end

  # Metrics

  def total_notes
    posts.inject do |sum, post|
      notes_for_post = post.post_data_sets.last.notes.to_i 
      sum + notes_for_post
    end
  end  
end