class CreateBlogDataSets < ActiveRecord::Migration
  def change
    create_table :blog_data_sets do |t|
      t.integer :post_id
      t.integer :followers

      t.timestamps
    end
  end
end
