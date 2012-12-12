class Blog < ActiveRecord::Base
  attr_accessible :authorization_id, :title, :update, :url

  belongs_to :authorization
  has_many :posts

  def self.initialize_tumblr(token, secret)
    @tumblr = TumblrData.new(token, secret)
  end

  def self.create_all_from_tumblr(token, secret)
    initialize_tumblr(token, secret)
    @tumblr.blogs.each do |tumblr_blog|
      find_or_create_from_tumblr(tumblr_blog)
    end
  end

  def self.find_or_create_from_tumblr(tumblr_blog)
    blog = find_by_title_and_url(tumblr_blog["title"], tumblr_blog["url"])
    unless blog
      create_from_tumblr(tumblr_blog)
    else
      blogs
    end
  end

  def self.create_from_tumblr(tumblr_blog)
    create! do |blog|
      blog.url        = parse_url(tumblr_blog["url"].to_s)
      blog.title      = tumblr_blog["title"]
      blog.written_at = tumblr_blog["updated"].to_s
    end
  end

  def self.parse_url(url)
    url = Domainatrix.parse(url)
    url.subdomain + url.host
  end    
end 

