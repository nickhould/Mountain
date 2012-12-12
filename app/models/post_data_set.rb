class PostDataSet < ActiveRecord::Base
  attr_accessible :notes, :uid, :post_id
  belongs_to :post


   # TODO - validate : if post && post.post_data_set.posted_at != tumblr_post["date"] 
  def self.update_from_post(post, tumblr_post)
    if post && !post.post_data_sets.find_by_created_at(Date.today) 
      post.post_data_sets.create_from_post(tumblr_post)
    ends
  end

  def self.create_from_post(tumblr_post)
    create! do |data_set|
      data_set.uid        = tumblr_post["id"]
      data_set.notes      = tumblr_post["note_count"]
    end 
  end
end
