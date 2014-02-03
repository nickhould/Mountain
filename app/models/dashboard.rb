require 'uri' # consider moving this require to your application.rb
class Dashboard < ActiveRecord::Base
  after_save :create_all_post_from_blog
  attr_accessible :name, :web_property_id, :user_id, :blog_id

  belongs_to :user
  belongs_to :blog

  validates_presence_of :name, :user_id, :blog_id

  # Tumblr
  def create_all_post_from_blog
    blog.create_posts_from_tumblr(user.tumblr_token, user.tumblr_secret)
  end

  def total_notes
    blog.total_notes
  end

  def total_posts
    blog.total_posts
  end

  def average_notes_per_post
    if total_notes > 0 && total_posts > 0
      avg = ( total_notes.to_f / total_posts.to_f ).to_f.round(2)
    else
      avg = 0
    end
  end

  def followers
    blog.followers
  end
end
