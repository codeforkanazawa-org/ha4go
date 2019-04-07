class AddIndexNameToSkills < ActiveRecord::Migration[4.2]
  def change
      add_index :skills, [:name], :unique => true
  end
end
