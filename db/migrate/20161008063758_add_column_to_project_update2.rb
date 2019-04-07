class AddColumnToProjectUpdate2 < ActiveRecord::Migration[4.2]
  def change
    add_column :project_updates, :freezing, :boolean
  end
end
