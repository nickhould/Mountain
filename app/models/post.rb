class Post < ActiveRecord::Base
  attr_accessible :blog_id, :notes, :title, :url

  belongs_to :blog

end
