class RemoveColumnUser < ActiveRecord::Migration[4.2]
  def change
      remove_column :users, :facebook_user_id
      remove_column :users, :password
  end
end
