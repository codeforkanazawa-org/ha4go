class RemoveDeleteFlagFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :delete_flag, :integer
  end
end
