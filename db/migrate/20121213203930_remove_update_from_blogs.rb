class RemoveUpdateFromBlogs < ActiveRecord::Migration
  def up
    remove_column :blogs, :update
  end

  def down
    add_column :blogs, :update, :integer
  end
end
