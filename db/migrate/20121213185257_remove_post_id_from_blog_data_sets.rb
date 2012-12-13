class RemovePostIdFromBlogDataSets < ActiveRecord::Migration
  def up
    remove_column :blog_data_sets, :post_id
  end

  def down
    add_column :blog_data_sets, :post_id, :integer
  end
end
