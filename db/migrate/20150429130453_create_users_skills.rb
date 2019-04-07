class CreateUsersSkills < ActiveRecord::Migration[4.2]
  def change
    create_table :users_skills do |t|
      t.integer :user_id
      t.integer :skill_id

      t.timestamps null: false
    end
  end
end
