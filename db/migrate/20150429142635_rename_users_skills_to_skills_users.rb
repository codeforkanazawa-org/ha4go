class RenameUsersSkillsToSkillsUsers < ActiveRecord::Migration[4.2]
  def change
      rename_table :users_skills, :skills_users
  end
end
