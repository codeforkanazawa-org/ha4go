class ChangeColumnToProjectUpdate < ActiveRecord::Migration
  def change
    change_column :project_updates, :description, :text
  end
end
