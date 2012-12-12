class CreatePostDataSets < ActiveRecord::Migration
  def change
    create_table :post_data_sets do |t|
      t.string :uid
      t.integer :notes

      t.timestamps
    end
  end
end
