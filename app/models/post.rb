class Post < ActiveRecord::Base
  attr_accessible :blog_id, :notes, :title, :url

  belongs_to :blog


  def self.initialize_tumblr(token, secret)
    @tumblr = TumblrData.new(token, secret)
  end

  def self.create_all_from_tumblr
    initialize_tumblr(token, secret)
    @tumblr.posts(url).each do |tumblr_blog|
      find_or_create_from_tumblr(tumblr_blog)
    end
  end


# <% @posts.each do |post| %>
# id: <%= post["id"] %><br>
# post_url :<%= post["post_url"] %><br>
# date:<%= post["date"] %><br>
# type: <%= post["type"] %><br>
# title: <%= post["title"] %><br>
# <% end  %>
end
