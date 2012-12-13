class BlogDataSet < ActiveRecord::Base
  attr_accessible :followers, :blog_id

  belongs_to :blog

  def self.update_from_blog(blog, tumblr_blog)
    if blog && !blog.blog_data_sets.find_by_created_at_and_blog_id(Date.today, blog.id) 
      blog.blog_data_sets.create_from_blog(tumblr_blog)
    end
  end


  def self.create_from_blog(tumblr_blog)
    create! do |data_set|
      data_set.followers = tumblr_blog["followers"]
    end
  end

end
