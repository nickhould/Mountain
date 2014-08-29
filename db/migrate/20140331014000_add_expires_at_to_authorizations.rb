class AddExpiresAtToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :expires_at, :integer
  end
end
