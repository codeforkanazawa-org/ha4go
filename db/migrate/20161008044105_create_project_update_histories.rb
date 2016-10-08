class CreateProjectUpdateHistories < ActiveRecord::Migration
  def change
    create_table :project_update_histories do |t|
      t.references :project_update, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
