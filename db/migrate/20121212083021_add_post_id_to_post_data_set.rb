class AddPostIdToPostDataSet < ActiveRecord::Migration
  def change
    add_column :post_data_sets, :post_id, :integer
  end
end
