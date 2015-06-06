class RemoveColumnUser < ActiveRecord::Migration
  def change
      remove_column :users, :facebook_user_id
      remove_column :users, :password
  end
end
