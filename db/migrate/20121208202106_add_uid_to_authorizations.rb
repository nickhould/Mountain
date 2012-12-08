class AddUidToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :uid, :string
  end
end
