class AddWebPropertyIdToDashboard < ActiveRecord::Migration
  def change
    add_column :dashboards, :web_property_id, :string
  end
end
