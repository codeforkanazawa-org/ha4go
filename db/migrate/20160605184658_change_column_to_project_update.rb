class ChangeColumnToProjectUpdate < ActiveRecord::Migration[4.2]
  def change
    change_column :project_updates, :description, :text
  end
end
