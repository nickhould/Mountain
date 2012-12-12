class RemoveFollowersFromBlog < ActiveRecord::Migration
  def up
    remove_column :blogs, :followers
  end

  def down
    add_column :blogs, :followers, :integer
  end
end
