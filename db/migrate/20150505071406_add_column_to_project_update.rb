class AddColumnToProjectUpdate < ActiveRecord::Migration
  def change
    add_column :project_updates, :user_id, :integer
  end
end
