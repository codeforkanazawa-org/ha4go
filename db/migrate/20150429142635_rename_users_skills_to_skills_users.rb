class RenameUsersSkillsToSkillsUsers < ActiveRecord::Migration
  def change
      rename_table :users_skills, :skills_users
  end
end
