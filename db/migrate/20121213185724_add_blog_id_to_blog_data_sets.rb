class AddBlogIdToBlogDataSets < ActiveRecord::Migration
  def change
    add_column :blog_data_sets, :blog_id, :integer
  end
end
