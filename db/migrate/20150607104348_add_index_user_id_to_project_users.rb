class AddIndexUserIdToProjectUsers < ActiveRecord::Migration[4.2]
  def change
      add_index :projects_users, [:user_id, :project_id], :unique => true
  end
end
