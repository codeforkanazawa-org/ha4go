class CreateProjectsUsers < ActiveRecord::Migration
  def change
    create_table :projects_users do |t|
      t.integer :project_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
