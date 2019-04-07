class CreateProjects < ActiveRecord::Migration[4.2]
  def change
    create_table :projects do |t|
      t.integer :user_id
      t.integer :stage_id
      t.string :subject
      t.string :description
      t.string :user_url
      t.string :development_url
      t.integer :delete_flag

      t.timestamps null: false
    end
  end
end
