class RemoveTumblogUrlFromDashboards < ActiveRecord::Migration
  def up
    remove_column :dashboards, :tumblog_url
  end

  def down
    add_column :dashboards, :tumblog_url, :string
  end
end
