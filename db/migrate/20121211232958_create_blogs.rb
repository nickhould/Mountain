class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :url
      t.string :title
      t.integer :posts
      t.integer :followers
      t.integer :written_at
      t.integer :authorization_id

      t.timestamps
    end
  end
end
