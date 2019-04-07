class AddColumnToProjectUpdate < ActiveRecord::Migration[4.2]
  def change
    add_column :project_updates, :user_id, :integer
  end
end
