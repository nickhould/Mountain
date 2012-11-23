class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :web_property_id
      t.string :title

      t.timestamps
    end
  end
end
