class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.string :provider
      t.integer :user_id
      t.string :access_token

      t.timestamps
    end
  end
end
