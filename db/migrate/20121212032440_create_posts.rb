class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :blog_id
      t.string :url
      t.string :title
      t.integer :notes

      t.timestamps
    end
  end
end
