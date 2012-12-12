class RemoveNotesFromPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :notes
  end

  def down
    add_column :posts, :notes, :integer
  end
end
