class AddBlogIdToDashboards < ActiveRecord::Migration
  def change
    add_column :dashboards, :blog_id, :integer
  end
end
