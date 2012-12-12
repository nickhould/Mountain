class AddTypeOfToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :type_of, :string
  end
end
