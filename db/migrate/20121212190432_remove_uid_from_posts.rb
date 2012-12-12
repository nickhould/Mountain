class RemoveUidFromPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :uid
  end

  def down
    add_column :posts, :uid, :string
  end
end
