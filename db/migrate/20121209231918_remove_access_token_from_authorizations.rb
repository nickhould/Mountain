class RemoveAccessTokenFromAuthorizations < ActiveRecord::Migration
  def up
    remove_column :authorizations, :access_token
  end

  def down
    add_column :authorizations, :access_token, :string
  end
end
