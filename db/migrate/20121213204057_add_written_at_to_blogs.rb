class AddWrittenAtToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :written_at, :integer
  end
end
