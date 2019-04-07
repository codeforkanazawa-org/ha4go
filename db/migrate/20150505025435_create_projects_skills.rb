class CreateProjectsSkills < ActiveRecord::Migration[4.2]
  def change
    create_table :projects_skills do |t|
      t.integer :project_id
      t.integer :skill_id

      t.timestamps null: false
    end
  end
end
