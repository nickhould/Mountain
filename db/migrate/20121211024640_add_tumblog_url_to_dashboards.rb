class AddTumblogUrlToDashboards < ActiveRecord::Migration
  def change
    add_column :dashboards, :tumblog_url, :string
  end
end
