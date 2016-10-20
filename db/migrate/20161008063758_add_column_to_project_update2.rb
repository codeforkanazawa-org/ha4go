class AddColumnToProjectUpdate2 < ActiveRecord::Migration
  def change
    add_column :project_updates, :freezing, :boolean
  end
end
