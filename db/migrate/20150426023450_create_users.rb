class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :description
      t.integer :facebook_user_id
      t.integer :delete_flag

      t.timestamps null: false
    end
  end
end
