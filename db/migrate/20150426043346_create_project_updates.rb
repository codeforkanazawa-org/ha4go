class CreateProjectUpdates < ActiveRecord::Migration[4.2]
  def change
    create_table :project_updates do |t|
      t.integer :project_id
      t.string :description
      t.integer :delete_flag

      t.timestamps null: false
    end
  end
end
