class RemovePostsFromBlog < ActiveRecord::Migration
  def up
    remove_column :blogs, :posts
  end

  def down
    add_column :blogs, :posts, :integer
  end
end
